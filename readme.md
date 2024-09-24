## 개발자 성장을 위한 첫걸음 PerfectFolio와 함께
![perfectfolio](https://github.com/user-attachments/assets/de7547c6-407e-46b7-9b79-7c6b49167b2c)

## ❓ PerfectFolio?  
## - **Perfect + Folio** 
#### 자체적인 기준으로 포트폴리오를 매칭하다.
- 퍼펙트폴리오는 개발자 취업준비생과 기업을
매칭해드리는 서비스를 제공하는 플랫폼입니다.
- 매일 공고를 찾아보느라 소비되는 30분,
퍼펙트폴리오는 개발자를 위해 개발자가
소비하는 시간을 절약할 수 있도록
효율적인 방법을 찾고자 시작한 서비스입니다.
- 개발자가 작업에만 집중할 수 있도록.
퍼펙트폴리오가 만들어 드릴 수 있습니다.

## Matching Secret  
#### 포트폴리오 매칭은 어떻게 이루어질까요?
#### 1. 서칭
국내 모든 공고를 수시로 확인해요 . 
#### 2. 인공지능  
모든 공고를 AI로 분석해요.
#### 3. 알고리즘
최적의 분석을 통해 최적의 공고를 추천해요. 

## 🛠 Stacks 
- HTML5
- CSS
- JavaScript
- Chart.js
- Java
- Python
- Spring Boot
- JSP
- MySQL
- MongoDB
- JPA
- MyBatis
- AWS EC2
- AWS RDS
- Thymeleaf

## 🚀Tools
- Git
- Bash
- STS
- IntelliJ
- OpenAI API
- Clova ChatBot
- Ubuntu

## 👥 Collaboration
- GitHub
- Notion
- Discord
- Word
- KaKao Talk

## 시스템 환경
| SW | |
| --- | --- |
| OS | window 10, 11  |
| Browser | Chrome 버전 128.0.6613.84(공식 빌드) (64비트)
||Edge 버전 128.0.2739.42 (공식 빌드) (64비트) |
| Tool | Spring Tool Suite 4 Launcher 
||My SQL Workbench |
| Backend | JAVA 21
||Spring Boot (ver 3.3.0)
||Spring Boot Security
||Tomcat
||MySQL
||Lombok
||gson-2.8.6
||HikariCP 5.1.0
||Selenium-java-4.8.0
||Edge Driver |
| Version/Issue관리 | GitHub
||GitBash
||GitDesktop |
| Communication | Discord
||Notion |
| 외부 API | [소셜 로그인 API]
||https://developers.kakao.com/
||https://developers.naver.com/main/
||https://cloud.google.com/identity-platform/docs/web/google?hl=ko
||[소셜 결제 API]
||https://developers.kakao.com/
||https://developers.pay.naver.com/
||https://developers.tosspayments.com/
||[SMTP API]
||https://developers.google.com/gmail/api/guides/sending?hl=ko
||[AI API]
||https://openai.com/index/openai-api/ |

## API 명세서
### **[ Login APIs ]**

**Naver Login API**

- **Purpose**: Authenticate users via Naver accounts.
- **Endpoints**:
    - Authorization: `https://nid.naver.com/oauth2.0/authorize`
    - Token: `https://nid.naver.com/oauth2.0/token`
    - User Info: `https://openapi.naver.com/v1/nid/me`
- **Key Parameters**: `client_id`, `response_type`, `redirect_uri`, `state`
- **Response**: User data (name, email, profile image) in JSON.

**Kakao Login API**

- **Purpose**: Authenticate users via Kakao accounts.
- **Endpoints**:
    - Authorization: `https://kauth.kakao.com/oauth/authorize`
    - Token: `https://kauth.kakao.com/oauth/token`
    - User Info: `https://kapi.kakao.com/v2/user/me`
- **Key Parameters**: `client_id`, `redirect_uri`, `response_type`, `state`
- **Response**: User data (nickname, profile image, email) in JSON.

**Google Login API**

- **Purpose**: Authenticate users via Google accounts.
- **Endpoints**:
    - Authorization: `https://accounts.google.com/o/oauth2/auth`
    - Token: `https://oauth2.googleapis.com/token`
    - User Info: `https://www.googleapis.com/oauth2/v2/userinfo`
- **Key Parameters**: `client_id`, `response_type`, `redirect_uri`, `scope`
- **Response**: User data (name, email, profile picture) in JSON.

---

### **[ Payment APIs ]**

**Kakao Payment API**

- **Purpose**: Process payments via KakaoPay.
- **Endpoints**:
    - Ready: `https://kapi.kakao.com/v1/payment/ready`
    - Approve: `https://kapi.kakao.com/v1/payment/approve`
    - Cancel: `https://kapi.kakao.com/v1/payment/cancel`
- **Response**: Payment status, amount, and ID in JSON.

**Naver Payment API**

- **Purpose**: Process payments via Naver Pay.
- **Endpoints**:
    - Ready: `https://api.pay.naver.com/v1/payments/prepared`
    - Approve: `https://api.pay.naver.com/v1/payments/approve`
    - Cancel: `https://api.pay.naver.com/v1/payments/cancel`
- **Response**: Payment status, amount, and ID in JSON.

**Toss Payment API**

- **Purpose**: Process payments via Toss.
- **Endpoints**:
    - Ready: `https://api.tosspayments.com/v1/payments`
    - Approve: `https://api.tosspayments.com/v1/payments/approve`
    - Cancel: `https://api.tosspayments.com/v1/payments/cancel`
- **Response**: Payment status, amount, and ID in JSON.

---

### **[ Email API ]**

**Google SMTP API**

- **Purpose**: Send emails via Google's SMTP server.
- **Endpoints**:
    - SMTP Server: `smtp.gmail.com`
- **Key Parameters**:
    - `smtp_host`: `smtp.gmail.com`
    - `smtp_port`: `587` (TLS) or `465` (SSL)
    - `username`: Gmail account email address
    - `password`: Gmail account password (or App password for enhanced security)
- **Response**: Email delivery status, including success or failure information.

---

### **[ AI API ]**

**GPT API**

- **Purpose**: Generate text and handle natural language processing tasks.
- **Endpoints**:
    - Completion: `https://api.openai.com/v1/completions`
    - Chat: `https://api.openai.com/v1/chat/completions`
- **Key Parameters**: `model`, `prompt`, `max_tokens`, `temperature`
- **Response**: Generated text or chat responses in JSON.

## Notion
[notion Link](https://www.notion.so/PerfectFolio-Final-Project-f808a8e5ee894f2a99cd3a9e52c8b560)   

## PPT
https://www.canva.com/design/DAGRXqGD298/mWN1a3DRbLS1ufaHjazzIA/view?utm_content=DAGRXqGD298&utm_campaign=designshare&utm_medium=link&utm_source=editor

## ERD
![Copy of perfect_folio](https://github.com/user-attachments/assets/decbe3a6-6cde-46a3-b5c0-3ce3d48d4296)

- contributors
- https://github.com/chorok917
- https://github.com/Nam-Cheol
- https://github.com/jinnymo
- https://github.com/dbstjlee
- https://github.com/thxtdy
- https://github.com/HyeonProG
