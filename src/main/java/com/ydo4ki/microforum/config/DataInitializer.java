package com.ydo4ki.microforum.config;

import com.ydo4ki.microforum.model.Message;
import com.ydo4ki.microforum.model.Post;
import com.ydo4ki.microforum.model.Role;
import com.ydo4ki.microforum.model.User;
import com.ydo4ki.microforum.repository.MessageRepository;
import com.ydo4ki.microforum.repository.PostRepository;
import com.ydo4ki.microforum.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.DependsOn;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
@DependsOn({"passwordEncoder"})
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final MessageRepository messageRepository;
    private final PostRepository postRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public DataInitializer(UserRepository userRepository, 
                          MessageRepository messageRepository,
                          PostRepository postRepository,
                          PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.messageRepository = messageRepository;
        this.postRepository = postRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        if (userRepository.count() == 0) {
            initializeData();
        }
    }

    private void initializeData() {
        User admin = User.builder()
                .username("admin")
                .email("admin@ydo4ki.com")
                .password(passwordEncoder.encode("admin"))
                .role(Role.ADMIN)
                .bio("The king thinks:")
                .avatarPath("/uploads/avatars/default-admin.png")
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .build();
        userRepository.save(admin);

        User user = User.builder()
                .username("user")
                .email("user@ydo4ki.com")
                .password(passwordEncoder.encode("user"))
                .role(Role.USER)
                .bio("A pawn thinks:")
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .build();
        userRepository.save(user);
		
		User chessQueen = User.builder()
				.username("queen")
				.email("chessQueen@ydo4ki.com")
				.password(passwordEncoder.encode("black_sacrifice...THE_ROOOOOOOOOK"))
				.role(Role.USER)
				.bio("Why the heck am i the rook")
				.avatarPath("/uploads/avatars/67dd4c3e-6ea8-4f06-9a11-6f284ee347d8.jpg")
				.createdAt(LocalDateTime.now())
				.updatedAt(LocalDateTime.now())
				.build();
		userRepository.save(chessQueen);

        // initial messages
        Message welcome = Message.builder()
                .title("Welcome to MicroForum")
                .content("Welcome to MicroForum! Feel free to explore and contribute to the discussions")
                .author(admin)
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .build();
        messageRepository.save(welcome);

        Message reply = Message.builder()
                .content("Thanks for creating this forum! Looking forward to engaging with everyone here")
                .author(user)
                .parentMessage(welcome)
                .createdAt(LocalDateTime.now().plusMinutes(30))
                .updatedAt(LocalDateTime.now().plusMinutes(30))
                .build();
        messageRepository.save(reply);

        Message discussion = Message.builder()
                .title("Boots discussion")
                .content("I just bought new boots. The Spring Boots (badumtss.mp3)")
                .author(user)
                .createdAt(LocalDateTime.now().plusHours(1))
                .updatedAt(LocalDateTime.now().plusHours(1))
                .build();
        messageRepository.save(discussion);

        // initial posts
        Post adminPost = Post.builder()
                .content("I'm the admin, hello!")
                .author(admin)
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .build();
        postRepository.save(adminPost);

        Post userPost = Post.builder()
                .content("Hello there")
                .author(user)
                .createdAt(LocalDateTime.now().plusMinutes(45))
                .updatedAt(LocalDateTime.now().plusMinutes(45))
                .build();
        postRepository.save(userPost);
    }
}
