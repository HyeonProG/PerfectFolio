package com.tenco.perfectfolio.service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.tenco.perfectfolio.dto.CompanyPaymentDTO;
import com.tenco.perfectfolio.dto.PrincipalDTO;
import com.tenco.perfectfolio.dto.ProposalDTO;
import com.tenco.perfectfolio.dto.company.PayHistory;
import com.tenco.perfectfolio.repository.model.Portfolio;
import com.tenco.perfectfolio.repository.model.company.BookmarkEntity;
import com.tenco.perfectfolio.repository.interfaces.BookmarkRepository;
import com.tenco.perfectfolio.repository.interfaces.CompanyRepository;
import com.tenco.perfectfolio.repository.interfaces.PropasalRepository;
import com.tenco.perfectfolio.repository.interfaces.UserRepository;
import com.tenco.perfectfolio.repository.model.company.Bookmark;
import com.tenco.perfectfolio.repository.model.User;
import com.tenco.perfectfolio.repository.model.analystic.MongoUserModel;
import com.tenco.perfectfolio.repository.model.company.Proposal;
import com.tenco.perfectfolio.service.mongo.EmployeeMatchingService;
import com.tenco.perfectfolio.service.mongo.MongoUserService;
import org.bson.Document;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.text.DecimalFormat;
import java.util.*;

@Service
public class CompanyService {

	@Autowired
	private EmployeeMatchingService employeeMatchingService;
	@Autowired
	private MongoUserService mongoUserService;
	@Autowired
	private PortfolioService portfolioService;

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private CompanyRepository companyRepository;
	@Autowired
	private BookmarkRepository bookmarkRepository;
	@Autowired
	private PropasalRepository propasalRepository;
    @Autowired
    private UserService userService;

	/**
	 * userId로 사용자 존재 여부 조회
	 * 
	 * @param userId
	 * @return
	 */
	public PrincipalDTO searchUserId(String userId) {
	    User user = userRepository.findByUserId(userId);
	    if (user != null) {
	        // subscribing이 null인 경우에 대한 처리
	        String subscribing = (user.getSubscribing() != null) ? user.getSubscribing() : "default";

	        PrincipalDTO principalDTO = PrincipalDTO.builder()
	                .id(user.getId())
	                .userId(user.getUserId())
	                .username(user.getUsername())
	                .userSocialType(user.getSocialType())
	                .subscribing(subscribing) // null인 경우 처리
	                .orderName(user.getOrderName())
	                .build();

	        return principalDTO;
	    }
	    return null;
	}
	
	/**
	 * userId로 사용자 정보 조회
	 * 
	 * @param userId
	 * @return
	 */
	public User searchUserIdByUser(String userId) {
		User user = userRepository.findByUserId(userId);
		if (user != null) {
			return user;
		}
		return null;
	}
	
	public List<String> getSearchCategory() {
		return companyRepository.getCategories();
	}
	
    
    public boolean selectBookmark(Long comId, Long userId) {
    	List<BookmarkEntity> isBookmarkList = bookmarkRepository.findByComIdAndUserId(comId, userId);
    	if(isBookmarkList == null || isBookmarkList.isEmpty()) {
    		return false;
    	} else {
    		return true;
    	}
    }
    
    public void insertBookmark(BookmarkEntity dto) {
    	bookmarkRepository.save(dto);
    }
    
    // DELETE - comId와 userId로 북마크 삭제
    @Transactional
    public void deleteBookmark(Long comId, Long userId) {
    	bookmarkRepository.deleteByComIdAndUserId(comId, userId);
    }
    
    public List<Bookmark> getBookmarkList() {
    	return companyRepository.getBookmarkList();
    }

	public List<Integer> selectBookmarkUserList(Long comId) {
		return bookmarkRepository.findUserIdsByComId(comId);
	}

	public void insertProposal(Proposal dto) {
		propasalRepository.save(dto);
	}

	public List<Integer> selectProposalUserList(Long comId) {
		return propasalRepository.findUserIdsByComId(comId);
	}

    /**
	 * 결제 승인 로직
	 * 
	 * @param orderId
	 * @param amount
	 * @param paymentKey
	 * @param userId
	 * @return
	 * @throws Exception
	 */
    @Transactional
	public JSONObject confirmPayment(String orderId, Integer amount, String paymentKey, Integer userId, String orderName, Integer goodsEach)
			throws Exception {
		String secretKey = "test_sk_LkKEypNArWePvndZdKeL3lmeaxYG:";
		String authorizations = "Basic "
				+ Base64.getEncoder().encodeToString(secretKey.getBytes(StandardCharsets.UTF_8));

		URI uri = new URI("https://api.tosspayments.com/v1/payments/confirm");
		URL url = uri.toURL();
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setRequestProperty("Authorization", authorizations);
		connection.setRequestProperty("Content-Type", "application/json");
		connection.setRequestMethod("POST");
		connection.setDoOutput(true);

		JSONObject obj = new JSONObject();
		obj.put("orderId", orderId);
		obj.put("amount", amount);
		obj.put("paymentKey", paymentKey);
		obj.put("orderName", orderName);

		try (OutputStream outputStream = connection.getOutputStream()) {
			outputStream.write(obj.toString().getBytes(StandardCharsets.UTF_8));
		}

		int code = connection.getResponseCode();
		InputStream responseStream = (code == 200) ? connection.getInputStream() : connection.getErrorStream();
		JSONParser parser = new JSONParser();
		JSONObject jsonObject = (JSONObject) parser
				.parse(new InputStreamReader(responseStream, StandardCharsets.UTF_8));

		if (code == 200) {

			CompanyPaymentDTO companyPaymentDTO = CompanyPaymentDTO.builder().userId(userId).paymentKey(paymentKey)
					.orderId(orderId).amount(amount).orderName(orderName).build();

			// DB에 결제 정보 저장
			goodsInsertOrUpdate(userId, goodsEach, companyPaymentDTO);

			return jsonObject;
		} else {
			throw new Exception("Payment confirmation failed: " + jsonObject.get("message"));
		}
	}

	public List<Map<String, Object>> getSearchList(Map<String, Object> requestData, long comId) {
		List<String> qualifications = (List<String>) requestData.get("qualifications");
		Gson gson = new Gson();
		DecimalFormat df = new DecimalFormat("#.##%");

		List<Document> list = employeeMatchingService.calculateFulfillmentRate(qualifications);
		List<Integer> bookmarkList = selectBookmarkUserList(comId);
		List<Integer> proposalList = selectProposalUserList(comId);
		List<Integer> idList = new ArrayList<>();
		Map<String, Object> fulfillmentRateMap = new HashMap<>();
		for (Document document : list) {
			String jsonString = document.toJson();
			JsonObject json = JsonParser.parseString(jsonString).getAsJsonObject();
			idList.add(json.get("user_id").getAsInt());
			fulfillmentRateMap.put(String.valueOf(json.get("user_id").getAsInt()), df.format(json.get("fulfillmentRate").getAsDouble()));
		}

		List<MongoUserModel> userList = new ArrayList<>();

		for (Integer userId : idList) {
			userList.add(mongoUserService.findByUserId(userId));
		}
		List<Map<String, Object>> users = new ArrayList<>();

		for (MongoUserModel user : userList) {
			List<String> skills = new ArrayList<>();
			Map<String, Object> map = new HashMap<>();

			map.put("id", user.getUserId());

			List<User> userDtoList = userService.findAll();
			for(User userDTO : userDtoList) {
				if (userDTO != null) {
					if(user.getUserId() == userDTO.getId()) {

						String tempName = userDTO.getUsername();
						char[] filter = tempName.toCharArray();
						String name = "";
						for (int i = 0; i < filter.length; i++) {
							if (i == 0) {
								name += filter[i];
							} else {
								name += "O";
							}
						}
						if (name == null) {
							name = "OOO";
						}

						map.put("name", name);
					}
				}
			}



			if (bookmarkList.contains(user.getUserId())) {
				map.put("isFavorite", true);
			} else {
				map.put("isFavorite", false);
			}

			if (proposalList.contains(user.getUserId())) {
				map.put("isProposal", true);
			} else {
				map.put("isProposal", false);
			}

			Portfolio portfolio = portfolioService.getMyPortfolioApproval(user.getUserId());

			if(portfolio != null) {
				map.put("portfolio", portfolio);
			} else {
				map.put("portfolio", null);
			}

			map.put("rate", fulfillmentRateMap.get(String.valueOf(user.getUserId())));

			if(user.getUserSkill().getLanguage() != null && !user.getUserSkill().getLanguage().isEmpty()) {
				skills.addAll(user.getUserSkill().getLanguage().keySet());
			}
			if(user.getUserSkill().getFramework() != null && !user.getUserSkill().getFramework().isEmpty()) {
				skills.addAll(user.getUserSkill().getFramework().keySet());
			}
			if(user.getUserSkill().getSQL() != null && !user.getUserSkill().getSQL().isEmpty()) {
				skills.addAll(user.getUserSkill().getSQL().keySet());
			}
			if(user.getUserSkill().getNoSQL() != null && !user.getUserSkill().getNoSQL().isEmpty()) {
				skills.addAll(user.getUserSkill().getNoSQL().keySet());
			}
			if(user.getUserSkill().getDevOps() != null && !user.getUserSkill().getDevOps().isEmpty()) {
				skills.addAll(user.getUserSkill().getDevOps().keySet());
			}
			if(user.getUserSkill().getService() != null && !user.getUserSkill().getService().isEmpty()) {
				skills.addAll(user.getUserSkill().getService().keySet());
			}
			if(user.getQualification() != null && !user.getQualification().isEmpty()) {
				skills.addAll(user.getQualification().keySet());
			}
			if(user.getLinguistics() != null && !user.getLinguistics().isEmpty()) {
				skills.addAll(user.getLinguistics().keySet());
			}

			map.put("skills", skills);
			users.add(map);
		}

		// 태그와 일치하는 유저 필터링
		List<Map<String, Object>> filteredUsers = new ArrayList<>();
		for (Map<String, Object> user : users) {
			List<String> userSkills = (List<String>) user.get("skills");
			long matchCount = qualifications.stream().filter(userSkills::contains).count(); // 매칭된 태그 개수

			if (matchCount > 0) {
				user.put("matchCount", matchCount);
				user.put("totalSkills", userSkills.size());
				filteredUsers.add(user); // 필터링된 유저만 반환
			}
		}

		return filteredUsers;
	}

	public List<Map<String, Object>> getFavoriteList(long comId) {
		List<Map<String, Object>> favoriteUserList = new ArrayList<>();

		List<MongoUserModel> userList = new ArrayList<>();
		List<Integer> bookmarkList = selectBookmarkUserList(comId);
		List<Integer> proposalList = selectProposalUserList(comId);

		for (Integer userId : bookmarkList) {
			userList.add(mongoUserService.findByUserId(userId));
		}

		for (MongoUserModel user : userList) {
			List<String> skills = new ArrayList<>();
			Map<String, Object> map = new HashMap<>();

			map.put("id", user.getUserId());

			map.put("isFavorite", true);

			User userDTO = userService.searchById(user.getUserId());

			if(userDTO != null) {
				String tempName = userDTO.getUsername();
				char[] filter = tempName.toCharArray();
				String name = "";
				for (int i = 0; i < filter.length; i++) {
					if (i == 0) {
						name += filter[i];
					} else {
						name += "O";
					}
				}
				if(name == null) {
					name = "OOO";
				}

				map.put("name", name);
			}

			if (proposalList.contains(user.getUserId())) {
				map.put("isProposal", true);
			} else {
				map.put("isProposal", false);
			}

			Portfolio portfolio = portfolioService.getMyPortfolioApproval(user.getUserId());

			if(portfolio != null) {
				map.put("portfolio", portfolio);
			} else {
				map.put("portfolio", null);
			}



			if(user.getUserSkill().getLanguage() != null && !user.getUserSkill().getLanguage().isEmpty()) {
				skills.addAll(user.getUserSkill().getLanguage().keySet());
			}
			if(user.getUserSkill().getFramework() != null && !user.getUserSkill().getFramework().isEmpty()) {
				skills.addAll(user.getUserSkill().getFramework().keySet());
			}
			if(user.getUserSkill().getSQL() != null && !user.getUserSkill().getSQL().isEmpty()) {
				skills.addAll(user.getUserSkill().getSQL().keySet());
			}
			if(user.getUserSkill().getNoSQL() != null && !user.getUserSkill().getNoSQL().isEmpty()) {
				skills.addAll(user.getUserSkill().getNoSQL().keySet());
			}
			if(user.getUserSkill().getDevOps() != null && !user.getUserSkill().getDevOps().isEmpty()) {
				skills.addAll(user.getUserSkill().getDevOps().keySet());
			}
			if(user.getUserSkill().getService() != null && !user.getUserSkill().getService().isEmpty()) {
				skills.addAll(user.getUserSkill().getService().keySet());
			}
			if(user.getQualification() != null && !user.getQualification().isEmpty()) {
				skills.addAll(user.getQualification().keySet());
			}
			if(user.getLinguistics() != null && !user.getLinguistics().isEmpty()) {
				skills.addAll(user.getLinguistics().keySet());
			}

			map.put("skills", skills);
			favoriteUserList.add(map);
		}

		return favoriteUserList;
	}

	@Transactional
	public void goodsInsertOrUpdate(Integer comId, Integer goodsEach, CompanyPaymentDTO companyPaymentDTO) {
		companyRepository.insertPayment(companyPaymentDTO);
		int isGoods = companyRepository.getGoodsByComId(comId);

		if(isGoods == 0) {
			companyRepository.insertGoods(comId, goodsEach);
		} else {
			companyRepository.updateGoodsAdd(comId, goodsEach);
		}
	}

	public int checkProposalItem(Integer comId) {
		return companyRepository.selectGoods(comId);
	}

	public void useProposalItem(Integer comId) {
		companyRepository.updateGoodsMinus(comId);
	}

	public void acceptProposal(Integer userId, Integer comId, String status) {
		propasalRepository.updateProposalStatusByUserIdAndComId(userId.longValue(), comId.longValue(), status);
	}

	public void rejectProposal(Integer userId, Integer comId, String status) {
		propasalRepository.updateProposalStatusByUserIdAndComId(userId.longValue(), comId.longValue(), status);
	}

	public List<PayHistory> getPayHistory(Integer comId) {
		return companyRepository.selectPayHistory(comId);
	}

	public List<ProposalDTO> getProposal(Integer comId) {
		return companyRepository.selectProposal(comId);
	}

}
