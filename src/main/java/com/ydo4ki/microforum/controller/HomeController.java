package com.ydo4ki.microforum.controller;

import com.ydo4ki.microforum.model.Post;
import com.ydo4ki.microforum.model.User;
import com.ydo4ki.microforum.service.MessageService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class HomeController {

    private final MessageService messageService;

    @GetMapping("/")
    public String home(Model model, @AuthenticationPrincipal User currentUser) {
        model.addAttribute("messages", messageService.getAllTopLevelMessages());
        model.addAttribute("newPost", new Post());
		model.addAttribute("currentUser", currentUser);
        return "home";
    }
}
