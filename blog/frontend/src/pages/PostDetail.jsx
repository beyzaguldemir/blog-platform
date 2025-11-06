import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import { postsAPI } from '../api/posts';

const PostDetail = () => {
  const { id } = useParams();
  const [post, setPost] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    loadPost();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [id]);

  const loadPost = async () => {
    try {
      const data = await postsAPI.getOne(id);
      setPost(data);
    } catch (error) {
      console.error('Error loading post:', error);
      setError('Post not found');
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="flex justify-center items-center min-h-screen">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  if (error || !post) {
    return (
      <div className="max-w-4xl mx-auto text-center py-12">
        <h2 className="text-2xl font-bold text-gray-800 mb-4">Post Not Found</h2>
        <p className="text-gray-600 mb-6">The post you're looking for doesn't exist.</p>
        <Link
          to="/"
          className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition"
        >
          Back to Home
        </Link>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto">
      <Link
        to="/"
        className="inline-flex items-center text-blue-600 hover:text-blue-700 mb-6"
      >
        ← Back to Posts
      </Link>

      <article className="bg-white rounded-xl shadow-lg overflow-hidden">
        <div className="p-8">
          {/* Category Badge */}
          <div className="mb-4">
            <span className="bg-blue-100 text-blue-800 text-sm font-semibold px-4 py-2 rounded-full">
              {post.category?.name}
            </span>
          </div>

          {/* Title */}
          <h1 className="text-4xl font-bold text-gray-800 mb-4">
            {post.title}
          </h1>

          {/* Meta Information */}
          <div className="flex items-center text-gray-600 mb-6 pb-6 border-b">
            <div className="flex items-center">
              <div className="w-10 h-10 bg-gradient-to-r from-blue-600 to-purple-600 rounded-full flex items-center justify-center text-white font-semibold mr-3">
                {post.user?.name?.charAt(0).toUpperCase()}
              </div>
              <div>
                <div className="font-semibold text-gray-800">
                  {post.user?.name}
                </div>
                <div className="text-sm text-gray-500">
                  {post.user?.email}
                </div>
              </div>
            </div>
          </div>

          {/* Content */}
          <div className="prose max-w-none mb-8">
            <div className="text-gray-700 text-lg leading-relaxed whitespace-pre-wrap">
              {post.content}
            </div>
          </div>

          {/* Tags */}
          {post.tags && post.tags.length > 0 && (
            <div className="pt-6 border-t">
              <h3 className="text-sm font-semibold text-gray-600 mb-3">Tags:</h3>
              <div className="flex flex-wrap gap-2">
                {post.tags.map((tag) => (
                  <span
                    key={tag.id}
                    className="bg-gray-100 text-gray-700 px-3 py-1 rounded-full text-sm"
                  >
                    #{tag.name}
                  </span>
                ))}
              </div>
            </div>
          )}
        </div>
      </article>

      {/* Back Button at Bottom */}
      <div className="mt-8 text-center">
        <Link
          to="/"
          className="inline-block bg-gray-600 text-white px-6 py-3 rounded-lg hover:bg-gray-700 transition"
        >
          ← Back to All Posts
        </Link>
      </div>
    </div>
  );
};

export default PostDetail;

