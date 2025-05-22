package com.ydo4ki.microforum.controller;

import com.ydo4ki.microforum.model.User;
import com.ydo4ki.microforum.service.MessageService;
import com.ydo4ki.microforum.service.PostService;
import com.ydo4ki.microforum.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.Optional;

@Controller
@RequestMapping("/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final MessageService messageService;
    private final PostService postService;

    @GetMapping("/profile")
    public String currentUserProfile(@AuthenticationPrincipal User currentUser, Model model) {
        return "redirect:/users/" + currentUser.getId();
    }

    @GetMapping("/{id}")
    public String getUserProfile(@PathVariable Long id, Model model, @AuthenticationPrincipal User currentUser) {
        Optional<User> userOpt = userService.findById(id);
        if (userOpt.isEmpty()) {
            return "redirect:/";
        }
        
        User user = userOpt.get();
        model.addAttribute("profileUser", user);
        model.addAttribute("isOwner", currentUser != null && currentUser.getId().equals(user.getId()));
        model.addAttribute("messages", messageService.getMessagesByUser(id));
        model.addAttribute("posts", postService.getPostsByUser(id));
		model.addAttribute("currentUser", currentUser);
        
        return "user-profile";
    }

    @GetMapping("/edit")
    public String editProfileForm(Model model, @AuthenticationPrincipal User currentUser) {
        model.addAttribute("user", currentUser);
        return "edit-profile";
    }

    @PostMapping("/edit")
    public String updateProfile(@ModelAttribute User updatedUser,
                               @RequestParam(value = "avatar", required = false) MultipartFile avatar,
                               @AuthenticationPrincipal User currentUser,
                               RedirectAttributes redirectAttributes) {
        try {
            updatedUser.setId(currentUser.getId());
            userService.updateUser(updatedUser, avatar);
            redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully");
            return "redirect:/users/profile";
        } catch (IllegalArgumentException | IOException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update profile: " + e.getMessage());
            return "redirect:/users/edit";
        }
    }

    @GetMapping("/list")
    public String listUsers(Model model) {
        model.addAttribute("users", userService.findAllUsers());
        return "user-list";
    }
}
