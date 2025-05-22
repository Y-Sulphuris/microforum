package com.ydo4ki.microforum.service;

import com.ydo4ki.microforum.model.Role;
import com.ydo4ki.microforum.model.User;
import com.ydo4ki.microforum.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.DependsOn;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@DependsOn({"passwordEncoder"})
public class UserService implements UserDetailsService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with username: " + username));
        
        return user;
    }

    public User registerNewUser(User user, MultipartFile avatarFile) throws IOException {
        if (userRepository.existsByUsername(user.getUsername())) {
            throw new IllegalArgumentException("Username already exists");
        }
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new IllegalArgumentException("Email already exists");
        }

        user.setRole(Role.USER);
        
        String encodedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodedPassword);
        
		// logger is supposed to be here, but I don't want another log4j exploit
        System.out.println("Registering new user: " + user.getUsername());
        System.out.println("With role: " + user.getRole());

        if (avatarFile != null && !avatarFile.isEmpty()) {
            String avatarPath = saveAvatar(avatarFile);
            user.setAvatarPath(avatarPath);
        }

        return userRepository.save(user);
    }

    public User updateUser(User user, MultipartFile avatarFile) throws IOException {
        User existingUser = userRepository.findById(user.getId())
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        existingUser.setUsername(user.getUsername());
        existingUser.setEmail(user.getEmail());
        existingUser.setBio(user.getBio());

        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            existingUser.setPassword(passwordEncoder.encode(user.getPassword()));
        }

        if (avatarFile != null && !avatarFile.isEmpty()) {
            if (existingUser.getAvatarPath() != null) {
                Path oldAvatarPath = Paths.get(existingUser.getAvatarPath());
                try {
                    Files.deleteIfExists(oldAvatarPath);
                } catch (IOException e) {
                    System.err.println("Cannot delete old avatar: " + e.getMessage());
                }
            }
            
            String avatarPath = saveAvatar(avatarFile);
            existingUser.setAvatarPath(avatarPath);
        }

        return userRepository.save(existingUser);
    }

    private String saveAvatar(MultipartFile avatarFile) throws IOException {
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String uuidFilename = UUID.randomUUID().toString();
        String originalFilename = avatarFile.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String filename = uuidFilename + extension;
        
        Path filePath = Paths.get(uploadPath, filename);
        Files.write(filePath, avatarFile.getBytes());
        
        return "/uploads/avatars/" + filename;
    }

    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }

    public List<User> findAllUsers() {
        return userRepository.findAll();
    }
}
