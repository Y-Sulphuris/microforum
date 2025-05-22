package com.ydo4ki.microforum.controller;

import com.ydo4ki.microforum.model.Message;
import com.ydo4ki.microforum.model.User;
import com.ydo4ki.microforum.service.MessageService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/messages")
@RequiredArgsConstructor
public class MessageController {

    private final MessageService messageService;

    @GetMapping
    public String getAllMessages(Model model, @AuthenticationPrincipal User currentUser) {
        model.addAttribute("messages", messageService.getAllTopLevelMessages());
        model.addAttribute("newMessage", new Message());
		model.addAttribute("currentUser", currentUser);
        return "messages";
    }

    @GetMapping("/{id}")
    public String getMessageDetails(@PathVariable Long id, Model model, @AuthenticationPrincipal User currentUser) {
        Optional<Message> messageOpt = messageService.getMessageById(id);
        if (messageOpt.isEmpty()) {
            return "redirect:/messages";
        }
        
        Message message = messageOpt.get();
        model.addAttribute("message", message);
        model.addAttribute("replies", messageService.getRepliesForMessage(id));
        model.addAttribute("newReply", new Message());
		model.addAttribute("currentUser", currentUser);
        return "message-details";
    }

    @PostMapping
    public String createMessage(@ModelAttribute("newMessage") Message message,
                               @AuthenticationPrincipal User currentUser,
                               RedirectAttributes redirectAttributes) {
        try {
            messageService.createMessage(message, currentUser);
            redirectAttributes.addFlashAttribute("successMessage", "Message created successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to create message: " + e.getMessage());
        }
        return "redirect:/messages";
    }

    @PostMapping("/{id}/reply")
    public String replyToMessage(@PathVariable Long id,
                                @ModelAttribute("newReply") Message reply,
                                @AuthenticationPrincipal User currentUser,
                                RedirectAttributes redirectAttributes) {
        try {
            messageService.replyToMessage(reply, currentUser, id);
            redirectAttributes.addFlashAttribute("successMessage", "Reply added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to add reply: " + e.getMessage());
        }
        return "redirect:/messages/" + id;
    }

    @GetMapping("/{id}/edit")
    public String editMessageForm(@PathVariable Long id, Model model, @AuthenticationPrincipal User currentUser) {
        Optional<Message> messageOpt = messageService.getMessageById(id);
        if (messageOpt.isEmpty()) {
            return "redirect:/messages";
        }
        
        Message message = messageOpt.get();
        if (!message.getAuthor().getId().equals(currentUser.getId())) {
            return "redirect:/messages";
        }
        
        model.addAttribute("message", message);
		model.addAttribute("currentUser", currentUser);
        return "edit-message";
    }

    @PostMapping("/{id}/edit")
    public String updateMessage(@PathVariable Long id,
                               @ModelAttribute Message updatedMessage,
                               @AuthenticationPrincipal User currentUser,
                               RedirectAttributes redirectAttributes) {
        Optional<Message> messageOpt = messageService.getMessageById(id);
        if (messageOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Message not found");
            return "redirect:/messages";
        }
        
        Message message = messageOpt.get();
        if (!message.getAuthor().getId().equals(currentUser.getId())) {
            redirectAttributes.addFlashAttribute("errorMessage", "You can only edit your own messages");
            return "redirect:/messages";
        }
        
        message.setTitle(updatedMessage.getTitle());
        message.setContent(updatedMessage.getContent());
        
        messageService.updateMessage(message);
        redirectAttributes.addFlashAttribute("successMessage", "Message updated successfully");
        
        return "redirect:/messages/" + id;
    }

    @PostMapping("/{id}/delete")
    public String deleteMessage(@PathVariable Long id,
                               @AuthenticationPrincipal User currentUser,
                               RedirectAttributes redirectAttributes) {
        Optional<Message> messageOpt = messageService.getMessageById(id);
        if (messageOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Message not found");
            return "redirect:/messages";
        }
        
        Message message = messageOpt.get();
        if (!message.getAuthor().getId().equals(currentUser.getId())) {
            redirectAttributes.addFlashAttribute("errorMessage", "You can only delete your own messages");
            return "redirect:/messages";
        }
        
		// reply
        Long redirectId = null;
        if (message.getParentMessage() != null) {
            redirectId = message.getParentMessage().getId();
        }
        
        messageService.deleteMessage(id);
        redirectAttributes.addFlashAttribute("successMessage", "Message deleted successfully");
        
        if (redirectId != null) {
            return "redirect:/messages/" + redirectId;
        } else {
            return "redirect:/messages";
        }
    }
}
