package com.tenco.perfectfolio.repository.model.company;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "co_proposal")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class Proposal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private Long id;

    @Column(name = "com_id", nullable = false)
    private Long comId;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    // bookmark_date를 DB에서 기본값으로 설정하려면 nullable = false, updatable = false
    @Column(name = "proposal_date", nullable = false, updatable = false)
    private LocalDateTime proposalDate;

    @Column(name = "status", nullable = false)
    private String status;

    // 엔티티가 처음 저장되기 전 bookmark_date 필드에 현재 시간을 설정
    @PrePersist
    protected void onCreate() {
        if (proposalDate == null) {
            proposalDate = LocalDateTime.now(); // 기본값을 현재 시간으로 설정
        }
    }
}
