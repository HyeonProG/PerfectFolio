package com.tenco.perfectfolio.repository.model.company;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity(name = "NewBookmarkEntity")
@Table(name = "co_bookmark")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class BookmarkEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private Long id;

    @Column(name = "com_id", nullable = false)
    private Long comId;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    // bookmark_date를 DB에서 기본값으로 설정하려면 nullable = false, updatable = false
    @Column(name = "bookmark_date", nullable = false, updatable = false)
    private LocalDateTime bookmarkDate;

    // 엔티티가 처음 저장되기 전 bookmark_date 필드에 현재 시간을 설정
    @PrePersist
    protected void onCreate() {
        if (bookmarkDate == null) {
            bookmarkDate = LocalDateTime.now(); // 기본값을 현재 시간으로 설정
        }
    }
}
