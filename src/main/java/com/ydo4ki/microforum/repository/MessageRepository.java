package com.ydo4ki.microforum.repository;

import com.ydo4ki.microforum.model.Message;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageRepository extends JpaRepository<Message, Long> {
    List<Message> findByParentMessageIsNullOrderByCreatedAtDesc();
    List<Message> findByParentMessageIdOrderByCreatedAtAsc(Long parentId);
    List<Message> findByAuthorIdOrderByCreatedAtDesc(Long authorId);
}
