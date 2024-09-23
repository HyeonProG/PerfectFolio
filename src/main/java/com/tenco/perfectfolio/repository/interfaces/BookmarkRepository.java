package com.tenco.perfectfolio.repository.interfaces;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;

import com.tenco.perfectfolio.repository.model.company.BookmarkEntity;

import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface BookmarkRepository extends JpaRepository<BookmarkEntity,Long> {

	List<BookmarkEntity> findByComIdAndUserId(Long comId, Long userId);

    @Query(value = "SELECT user_id FROM co_bookmark WHERE com_id = :comId", nativeQuery = true)
    List<Integer> findUserIdsByComId(@Param("comId") Long comId);

    @Modifying
    @Transactional
    void deleteByComIdAndUserId(Long comId, Long userId);
	
}
