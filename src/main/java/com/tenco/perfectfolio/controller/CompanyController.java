package com.tenco.perfectfolio.controller;

import com.tenco.perfectfolio.dto.PrincipalDTO;
import com.tenco.perfectfolio.repository.model.User;
import com.tenco.perfectfolio.repository.model.company.Bookmark;
import com.tenco.perfectfolio.repository.model.company.BookmarkEntity;
import com.tenco.perfectfolio.repository.model.company.Proposal;
import com.tenco.perfectfolio.service.CompanyService;
import com.tenco.perfectfolio.service.EmailService;
import com.tenco.perfectfolio.service.UserService;
import com.tenco.perfectfolio.utils.Define;
import jakarta.servlet.http.HttpSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/company")
public class CompanyController {

    @Autowired
    private CompanyService companyService;
    @Autowired
    private EmailService emailService;
    @Autowired
    private HttpSession session;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private UserService userService;

    @GetMapping("/about")
    public String getMethodName() {
        return "about/aboutUS";
    }

    /**
     * 인재 검색 페이지 요청
     *
     * @return
     */
    @GetMapping("/search")
    public String getSearchPage(Model model) {
        PrincipalDTO principal = (PrincipalDTO)session.getAttribute("principal");
        if(principal == null) {
			return "redirect:user/sign-in";
		}
        model.addAttribute("companyId", principal.getId());
        return "company/search";
    }

    /**
     * 몽고로부터 유저 데이터를 받는 메소드
     * @param requestData
     * @return
     */
    @PostMapping("/search")
    @ResponseBody
    public List<Map<String, Object>> searchUsers(@RequestBody Map<String, Object> requestData) {
        PrincipalDTO principal = (PrincipalDTO)session.getAttribute("principal");
        return companyService.getSearchList(requestData, principal.getId().longValue());
    }

    @GetMapping("/favoriteList")
    public String getFavoritePage(Model model) {
        PrincipalDTO principal = (PrincipalDTO)session.getAttribute("principal");
        if(principal == null) {
			return "redirect:user/sign-in";
		}
        model.addAttribute("companyId", principal.getId());
        return "company/favorite";
    }

    @PostMapping("/favoriteList")
    @ResponseBody
    public List<Map<String, Object>> getFavoriteProc() {
        PrincipalDTO principal = (PrincipalDTO)session.getAttribute("principal");
        return companyService.getFavoriteList(principal.getId().longValue());
    }

    /**
     * 입사 제안서 결제 페이지 요청
     *
     * @return
     */
    @GetMapping("/payment")
    public String getPaymentPage(HttpSession session, Model model) {
        PrincipalDTO principal = (PrincipalDTO)session.getAttribute("principal");
        if (principal != null) {
            model.addAttribute("username", principal.getUsername());
            model.addAttribute("userId", principal.getId());
            System.out.println(principal.toString());
        } else {
            return "redirect:/user/sign-in";
        }

        return "company/payment";
    }

    /**
     * 결제 성공 처리 및 잔액 업데이트
     */
    @GetMapping("/success1")
    public String paymentResult1(Model model, @RequestParam("orderId") String orderId,
                                 @RequestParam("amount") Integer amount, @RequestParam("paymentKey") String paymentKey) throws Exception {

        PrincipalDTO principal = (PrincipalDTO)session.getAttribute("principal");
        if(principal == null) {
			return "redirect:user/sign-in";
		}
        int userId = principal.getId();

        try {
            String orderName = "입사 지원서 10개";

            // 결제 확인 서비스 호출
            JSONObject jsonObject = companyService.confirmPayment(orderId, amount, paymentKey, userId, orderName, 10);
            model.addAttribute("isSuccess", true);
            model.addAttribute("responseStr", jsonObject.toJSONString());

        } catch (Exception e) {
            model.addAttribute("isSuccess", false);
            model.addAttribute("message", e.getMessage());
        }

        return "company/success"; // 결제 성공 페이지
    }
    @GetMapping("/success2")
    public String paymentResult2(Model model, @RequestParam("orderId") String orderId,
                                 @RequestParam("amount") Integer amount, @RequestParam("paymentKey") String paymentKey) throws Exception {

        PrincipalDTO principal = (PrincipalDTO)session.getAttribute("principal");
        if(principal == null) {
			return "redirect:user/sign-in";
		}
        int userId = principal.getId();

        try {
            String orderName = "입사 지원서 30개";

            // 결제 확인 서비스 호출
            JSONObject jsonObject = companyService.confirmPayment(orderId, amount, paymentKey, userId, orderName, 30);
            model.addAttribute("isSuccess", true);
            model.addAttribute("responseStr", jsonObject.toJSONString());

        } catch (Exception e) {
            model.addAttribute("isSuccess", false);
            model.addAttribute("message", e.getMessage());
        }

        return "company/success"; // 결제 성공 페이지
    }
    @GetMapping("/success3")
    public String paymentResult3(Model model, @RequestParam("orderId") String orderId,
                                 @RequestParam("amount") Integer amount, @RequestParam("paymentKey") String paymentKey) throws Exception {

        PrincipalDTO principal = (PrincipalDTO)session.getAttribute("principal");
        if(principal == null) {
			return "redirect:user/sign-in";
		}
        int userId = principal.getId();

        try {
            String orderName = "입사 지원서 50개";

            // 결제 확인 서비스 호출
            JSONObject jsonObject = companyService.confirmPayment(orderId, amount, paymentKey, userId, orderName, 50);
            model.addAttribute("isSuccess", true);
            model.addAttribute("responseStr", jsonObject.toJSONString());

        } catch (Exception e) {
            model.addAttribute("isSuccess", false);
            model.addAttribute("message", e.getMessage());
        }

        return "company/success"; // 결제 성공 페이지
    }
    @GetMapping("/success4")
    public String paymentResult4(Model model, @RequestParam("orderId") String orderId,
                                 @RequestParam("amount") Integer amount, @RequestParam("paymentKey") String paymentKey) throws Exception {

        PrincipalDTO principal = (PrincipalDTO)session.getAttribute("principal");
        if(principal == null) {
			return "redirect:user/sign-in";
		}
        int userId = principal.getId();

        try {
            String orderName = "입사 지원서 100개";

            // 결제 확인 서비스 호출
            JSONObject jsonObject = companyService.confirmPayment(orderId, amount, paymentKey, userId, orderName, 100);
            model.addAttribute("isSuccess", true);
            model.addAttribute("responseStr", jsonObject.toJSONString());

        } catch (Exception e) {
            model.addAttribute("isSuccess", false);
            model.addAttribute("message", e.getMessage());
        }

        return "company/success"; // 결제 성공 페이지
    }

    /**
     * 결제 실패 처리
     */
    @GetMapping("/fail")
    public String paymentFail(Model model, @RequestParam(value = "message") String message,
                              @RequestParam(value = "code") String code) {

        model.addAttribute("isSuccess", false);
        model.addAttribute("code", code);
        model.addAttribute("message", message);

        return "company/fail"; // 결제 실패 페이지
    }

    @GetMapping("/tagList")
    @ResponseBody
    public List<String> getTagListProc() {
        return companyService.getSearchCategory();
    }

    // 즐겨찾기 상태를 가져오는 메소드
    @GetMapping("/favorite")
    @ResponseBody
    public ResponseEntity<List<Bookmark>> getFavorites() {
        List<Bookmark> favorites = companyService.getBookmarkList();
        return ResponseEntity.ok(favorites);
    }

    @PostMapping("/favorite")
    @ResponseBody
    public ResponseEntity<Map<String, String>> toggleFavorite(@RequestBody Map<String, Object> requestData) {
        // comId와 userId를 안전하게 받기 위한 처리
        Object comIdObj = requestData.get("comId");
        Object userIdObj = requestData.get("userId");

        Long comId = null;
        Long userId = null;

        try {
            if (comIdObj instanceof Number) {
                comId = ((Number) comIdObj).longValue();  // 숫자로 변환
            } else if (comIdObj instanceof String) {
                comId = Long.parseLong((String) comIdObj);  // String을 Long으로 변환
            }

            if (userIdObj instanceof Number) {
                userId = ((Number) userIdObj).longValue();  // 숫자로 변환
            } else if (userIdObj instanceof String) {
                userId = Long.parseLong((String) userIdObj);  // String을 Long으로 변환
            }
        } catch (NumberFormatException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("error", "잘못된 ID 형식입니다."));
        }

        Boolean isFavorite = (Boolean) requestData.get("favorite");

        // DB에서 해당 userId가 이미 존재하는지 확인
        boolean alreadyExists = companyService.selectBookmark(comId, userId);

        Map<String, String> response = new HashMap<>();

        if (alreadyExists) {
            response.put("error", "이미 즐겨찾기에 등록된 사용자입니다.");
            return ResponseEntity.status(HttpStatus.CONFLICT).body(response);
        } else {
            BookmarkEntity bookmark = BookmarkEntity.builder()
                    .comId(comId)
                    .userId(userId)
                    .build();
            companyService.insertBookmark(bookmark);

            response.put("message", "즐겨찾기 상태가 변경되었습니다.");
            return ResponseEntity.ok(response);
        }
    }

    @DeleteMapping("/favorite/delete")
    @ResponseBody
    public ResponseEntity<Map<String, String>> deleteFavorite(@RequestBody Map<String, Object> requestData) {
        Object comIdObj = requestData.get("comId");
        Object userIdObj = requestData.get("userId");

        Long comId = null;
        Long userId = null;

        try {
            if (comIdObj instanceof Number) {
                comId = ((Number) comIdObj).longValue();
            } else if (comIdObj instanceof String) {
                comId = Long.parseLong((String) comIdObj);
            }

            if (userIdObj instanceof Number) {
                userId = ((Number) userIdObj).longValue();
            } else if (userIdObj instanceof String) {
                userId = Long.parseLong((String) userIdObj);
            }
        } catch (NumberFormatException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("error", "잘못된 ID 형식입니다."));
        }

        companyService.deleteBookmark(comId, userId);

        Map<String, String> response = new HashMap<>();
        response.put("message", "즐겨찾기가 해제되었습니다.");
        return ResponseEntity.ok(response);
    }


    @PostMapping("/proposal")
    @ResponseBody
    public ResponseEntity<Map<String, String>> sendProposal(@RequestBody Map<String, Object> requestData) {
        Integer userId = (Integer) requestData.get("userId");
        PrincipalDTO principal = (PrincipalDTO)session.getAttribute("principal");
        // 이곳에서 userId를 사용하여 입사제안서 전송 로직을 처리
        User user = userService.searchById(userId);
        User company = userService.searchById(principal.getId());
        Map<String, String> response = new HashMap<>();

        int goodsQuantity = companyService.checkProposalItem(principal.getId());

        if (goodsQuantity > 0) {
            emailService.sendMailJobOffer("js11000@naver.com", company.getUsername(), user.getUsername(), user.getId(), principal.getId());
            companyService.useProposalItem(principal.getId());
            Proposal proposal = Proposal.builder()
                    .comId(principal.getId().longValue())
                    .userId(userId.longValue())
                    .status(Define.STATUS_USER_WAIT)
                    .build();
            companyService.insertProposal(proposal);
            response.put("message", "입사제안서가 전송되었습니다.");
            return ResponseEntity.ok(response);
        } else {
            response.put("error", "입사제안서 수량을 확인해주세요.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }

    }

    @GetMapping("/accept")
    public String proposalAccept(@RequestParam("userId") Integer userId, @RequestParam("comId") Integer comId) {

        companyService.acceptProposal(userId, comId, Define.STATUS_USER_ACCEPT);
        return "redirect:/user/main";
    }

    @GetMapping("/reject")
    public String proposalReject(@RequestParam("userId") Integer userId, @RequestParam("comId") Integer comId) {
        companyService.rejectProposal(userId, comId, Define.STATUS_USER_REFUSAL);
        return "redirect:/user/main";
    }

    @GetMapping("/my-info")
    public String getMyPage(Model model) {
        PrincipalDTO principal = (PrincipalDTO) session.getAttribute("principal");
        if(principal == null) {
			return "redirect:user/sign-in";
		}
        model.addAttribute("item", companyService.checkProposalItem(principal.getId()));
        return "company/myInfo";
    }

    @GetMapping("/payHistory")
    public String getPaymentHistoryPage(Model model) {
        PrincipalDTO principal = (PrincipalDTO) session.getAttribute("principal");
        if(principal == null) {
			return "redirect:user/sign-in";
		}
        model.addAttribute("payHistoryList", companyService.getPayHistory(principal.getId()));
        return "company/payHistory";
    }

    @GetMapping("/proposalHistory")
    public String getProposalHistory(Model model) {
        PrincipalDTO principal = (PrincipalDTO) session.getAttribute("principal");
        if(principal == null) {
			return "redirect:user/sign-in";
		}
        model.addAttribute("proposalList", companyService.getProposal(principal.getId()));
        return "company/proposal";
    }

    @GetMapping("/sign-up")
    public String getSignUp() {
        return "company/signUp";
    }

}