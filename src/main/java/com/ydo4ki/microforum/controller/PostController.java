package com.ydo4ki.microforum.controller;

import com.ydo4ki.microforum.model.Post;
import com.ydo4ki.microforum.model.User;
import com.ydo4ki.microforum.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/posts")
@RequiredArgsConstructor
public class PostController {

    private final PostService postService;

    @PostMapping
    public String createPost(@ModelAttribute Post post,
                            @AuthenticationPrincipal User currentUser,
                            RedirectAttributes redirectAttributes) {
        try {
            postService.createPost(post, currentUser);
            redirectAttributes.addFlashAttribute("successMessage", "Post created successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to create post: " + e.getMessage());
        }
        return "redirect:/users/profile";
    }

    @GetMapping("/{id}/edit")
    public String editPostForm(@PathVariable Long id, Model model, @AuthenticationPrincipal User currentUser) {
        Optional<Post> postOpt = postService.getPostById(id);
        if (postOpt.isEmpty()) {
            return "redirect:/users/profile";
        }
        
        Post post = postOpt.get();
        if (!post.getAuthor().getId().equals(currentUser.getId())) {
            return "redirect:/users/profile";
        }
        
        model.addAttribute("post", post);
		model.addAttribute("currentUser", currentUser);
        return "edit-post";
    }

    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id,
                            @ModelAttribute Post updatedPost,
                            @AuthenticationPrincipal User currentUser,
                            RedirectAttributes redirectAttributes) {
        Optional<Post> postOpt = postService.getPostById(id);
        if (postOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Post not found");
            return "redirect:/users/profile";
        }
        
        Post post = postOpt.get();
        if (!post.getAuthor().getId().equals(currentUser.getId())) {
            redirectAttributes.addFlashAttribute("errorMessage", "You can only edit your own posts");
            return "redirect:/users/profile";
        }
        
        post.setContent(updatedPost.getContent());
        
        postService.updatePost(post);
        redirectAttributes.addFlashAttribute("successMessage", "Post updated successfully");
        
        return "redirect:/users/profile";
    }

    @PostMapping("/{id}/delete")
    public String deletePost(@PathVariable Long id,
                            @AuthenticationPrincipal User currentUser,
                            RedirectAttributes redirectAttributes) {
        Optional<Post> postOpt = postService.getPostById(id);
        if (postOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Post not found");
            return "redirect:/users/profile";
        }
        
        Post post = postOpt.get();
        if (!post.getAuthor().getId().equals(currentUser.getId())) {
            redirectAttributes.addFlashAttribute("errorMessage", "You can only delete your own posts");
            return "redirect:/users/profile";
        }
        
        postService.deletePost(id);
        redirectAttributes.addFlashAttribute("successMessage", "Post deleted successfully");
        
        return "redirect:/users/profile";
    }
}
