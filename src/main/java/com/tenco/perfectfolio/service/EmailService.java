package com.tenco.perfectfolio.service;

import com.tenco.perfectfolio.dto.PrincipalDTO;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring6.SpringTemplateEngine;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;

@Service
public class EmailService {

	@Autowired
	private JavaMailSender javaMailSender;
	private Map<String, String> validatedCode = new HashMap<>();
	private ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

	@Autowired
	private SpringTemplateEngine templateEngine;

	/**
	 * 이메일을 보내는 메소드
	 * 
	 * @param to      = 수신자
	 * @param subject = 제목
	 * @param text    = 내용
	 */
	public void sendMail(String to, String subject, String templateName, String text) {
		try {
			// Thymeleaf 문법
			// Controller 에서 받은 인증코드를,
			// Context 클래스를 이용해서
			// templates/sendValidateCode.html 로 보냅니다.
			Context context = new Context();
			context.setVariable("validationCode", text);

			String htmlFile = templateEngine.process(templateName, context);

			MimeMessage mimeMessage = javaMailSender.createMimeMessage();
			MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, false, "UTF-8");

			// 메일 수신자
			mimeMessageHelper.setTo(to);
			// 메일 제목
			mimeMessageHelper.setSubject(subject);
			// 본문에 첨부할 html 파일, true 는 html 허용 유무를 나타냄
			mimeMessageHelper.setText(htmlFile, true);

			javaMailSender.send(mimeMessage);
			System.out.println("Sent email to " + to);
		} catch (MessagingException e) {
			throw new RuntimeException("Email을 보내는데에 오류가 생겼습니다.", e);
		}
	}

	/**
	 * 아이디 찾기 이메일 발송
	 * @param to
	 * @param subject
	 * @param dto
	 */
	public void sendMailByUserId(String to, String subject, PrincipalDTO dto) {
		try {
			// Thymeleaf 문법
			// Context 클래스를 이용하여 템플릿에 필요한 데이터를 설정합니다.
			Context context = new Context();
			context.setVariable("username", dto.getUsername());
			context.setVariable("userId", dto.getUserId());

			// 템플릿 처리(이메일 본문)
			String htmlFile = templateEngine.process("findUserIdByEmail", context);
			// context: 템플릿에서 사용할 데이터 모델

			// MimeMessage 객체 생성
			// 이메일 메시지의 본문과 메타데이터를 포함하는 클래스
			MimeMessage mimeMessage = javaMailSender.createMimeMessage();
			
			// MimeMessageHelper 객체 생성
			// MimeMessage 객체를 쉽게 다룰 수 있게 도와주는 클래스
			MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, false, "UTF-8");
			// 파일 첨부 여부: false

			// 수신자의 메일 주소
			mimeMessageHelper.setTo(to);
			// 메일 제목
			mimeMessageHelper.setSubject(subject);
			// 본문에 첨부할 html 파일, true 는 html 허용 유무를 나타냄
			mimeMessageHelper.setText(htmlFile, true);

			// 이메일 전송
			javaMailSender.send(mimeMessage);
			System.out.println("Sent email to " + to);
		} catch (MessagingException e) {
			throw new RuntimeException("Email을 보내는데에 오류가 생겼습니다.", e);
		}

	}

	/**
	 * 입사 제안서 이메일 양식
	 * 
	 * @param to
	 */
	public void sendMailJobOffer(String to, String companyName, String userName, Integer userId, Integer comId) {
		try {
			// Thymeleaf 문법
			// Controller 에서 받은 인증코드를,
			// Context 클래스를 이용해서
			// templates/sendValidateCode.html 로 보냅니다.
			Context context = new Context();
			context.setVariable("companyName", companyName);
			context.setVariable("userName", userName);
			context.setVariable("userId", userId);
			context.setVariable("comId", comId);

			String htmlFile = templateEngine.process("jobOffer", context);

			MimeMessage mimeMessage = javaMailSender.createMimeMessage();
			MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, false, "UTF-8");

			// 메일 수신자
			mimeMessageHelper.setTo(to);
			// 메일 제목
			mimeMessageHelper.setSubject("입사 제안 안내");
			// 본문에 첨부할 html 파일, true 는 html 허용 유무를 나타냄
			mimeMessageHelper.setText(htmlFile, true);

			javaMailSender.send(mimeMessage);
			System.out.println("Sent email to " + to);
		} catch (MessagingException e) {
			throw new RuntimeException("Email을 보내는데에 오류가 생겼습니다.", e);
		}
	}

		public void sendRecommendation(String to, String userName, int recommendationCount) {

			try {
				Context context = new Context();
				context.setVariable("userName", userName);
				context.setVariable("recommendationCount", recommendationCount);
				String htmlFile = templateEngine.process("sendRecommendationMail", context);
				MimeMessage mimeMessage = javaMailSender.createMimeMessage();
				MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, false, "UTF-8");

				// 메일 수신자
				mimeMessageHelper.setTo(to);
				// 메일 제목
				mimeMessageHelper.setSubject("시크릿 매칭");
				// 본문에 첨부할 html 파일, true 는 html 허용 유무를 나타냄
				mimeMessageHelper.setText(htmlFile, true);

				javaMailSender.send(mimeMessage);
			} catch (MessagingException e) {
				throw new RuntimeException("Email을 보내는 중 오류가 발생했습니다.");
			}

		}

}