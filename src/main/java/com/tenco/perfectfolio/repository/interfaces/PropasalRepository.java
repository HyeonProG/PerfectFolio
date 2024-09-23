package com.tenco.perfectfolio.repository.interfaces;

import com.tenco.perfectfolio.repository.model.company.Proposal;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PropasalRepository extends JpaRepository<Proposal,Long> {

    List<Proposal> findByComIdAndUserId(Long comId, Long userId);

    @Query(value = "SELECT user_id FROM co_proposal WHERE com_id = :comId", nativeQuery = true)
    List<Integer> findUserIdsByComId(@Param("comId") Long comId);

    @Modifying
    @Transactional
    void deleteByComIdAndUserId(Long comId, Long userId);

    @Modifying
    @Transactional
    @Query("UPDATE Proposal p SET p.status = :status WHERE p.userId = :userId AND p.comId = :comId")
    int updateProposalStatusByUserIdAndComId(@Param("userId") Long userId,
                                             @Param("comId") Long comId,
                                             @Param("status") String status);
}
