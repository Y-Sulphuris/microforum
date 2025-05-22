package com.ydo4ki.microforum.service;

import com.ydo4ki.microforum.model.Post;
import com.ydo4ki.microforum.model.User;
import com.ydo4ki.microforum.repository.PostRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PostService {

    private final PostRepository postRepository;

    public List<Post> getPostsByUser(Long userId) {
        return postRepository.findByAuthorIdOrderByCreatedAtDesc(userId);
    }

    public Post createPost(Post post, User author) {
        post.setAuthor(author);
        return postRepository.save(post);
    }

    public Optional<Post> getPostById(Long id) {
        return postRepository.findById(id);
    }

    public void deletePost(Long id) {
        postRepository.deleteById(id);
    }

    public Post updatePost(Post post) {
        return postRepository.save(post);
    }
}
