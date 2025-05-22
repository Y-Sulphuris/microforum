<#import "layout/base.ftlh" as layout>

<@layout.base title="Edit Post - MicroForum">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h4>Edit Post</h4>
                </div>
                <div class="card-body">
                    <form action="/posts/${post.id}/edit" method="post">
                        <div class="mb-3">
                            <label for="content" class="form-label">Content</label>
                            <textarea class="form-control" id="content" name="content" rows="4" required>${post.content}</textarea>
                        </div>
                        <div class="d-flex justify-content-between">
                            <a href="/users/profile" class="btn btn-outline-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@layout.base>
