package com.ydo4ki.microforum.service;

import com.ydo4ki.microforum.model.Message;
import com.ydo4ki.microforum.model.User;
import com.ydo4ki.microforum.repository.MessageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MessageService {

    private final MessageRepository messageRepository;

    public List<Message> getAllTopLevelMessages() {
        return messageRepository.findByParentMessageIsNullOrderByCreatedAtDesc();
    }

    public List<Message> getRepliesForMessage(Long parentId) {
        return messageRepository.findByParentMessageIdOrderByCreatedAtAsc(parentId);
    }

    public List<Message> getMessagesByUser(Long userId) {
        return messageRepository.findByAuthorIdOrderByCreatedAtDesc(userId);
    }

    public Message createMessage(Message message, User author) {
        message.setAuthor(author);
        return messageRepository.save(message);
    }

    public Message replyToMessage(Message reply, User author, Long parentId) {
        Optional<Message> parentMessageOpt = messageRepository.findById(parentId);
        if (parentMessageOpt.isEmpty()) {
            throw new IllegalArgumentException("Parent message not found");
        }
        
        Message parentMessage = parentMessageOpt.get();
        reply.setAuthor(author);
        reply.setParentMessage(parentMessage);
        
        if (reply.getTitle() == null || reply.getTitle().isEmpty()) {
            reply.setTitle("Re: " + parentMessage.getTitle());
        }
        
        return messageRepository.save(reply);
    }

    public Optional<Message> getMessageById(Long id) {
        return messageRepository.findById(id);
    }

    public void deleteMessage(Long id) {
        messageRepository.deleteById(id);
    }

    public Message updateMessage(Message message) {
        return messageRepository.save(message);
    }
}
