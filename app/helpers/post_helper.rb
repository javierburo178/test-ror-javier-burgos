module PostHelper
  def posts_index(posts)
    if posts.any?
      render partial: 'posts/post', collection: posts
    else
      render partial: 'partials/no_content'
    end
  end

  def post_image(post)
    post.image.attached? ? post.image : asset_path('rails.png')
  end

  def post_description(post)
    truncate(strip_tags(post.description.to_s), length: 80)
  end

  def post_categories
    Post.categories.keys.map { |c| [c.humanize, c] }
  end
end