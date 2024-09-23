package com.tenco.perfectfolio.repository.model.company;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "crawl_skill_json")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@ToString(exclude = {"crawlJson", "gptJson", "mongoJson"})
public class NoticeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private Long id;

    @Column(name = "notice_id")
    private Long noticeId;

    @Column(name = "crawl_json", columnDefinition = "JSON")
    private String crawlJson;  // MySQL JSON 타입을 String으로 매핑

    @Column(name = "gpt_json", columnDefinition = "JSON")
    private String gptJson;    // MySQL JSON 타입을 String으로 매핑

    @Column(name = "mongo_json", columnDefinition = "JSON")
    private String mongoJson;  // MySQL JSON 타입을 String으로 매핑

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "compleion")
    private boolean compleion;
}