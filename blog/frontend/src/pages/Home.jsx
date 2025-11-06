import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { postsAPI } from '../api/posts';

const Home = () => {
  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadPosts();
  }, []);

  const loadPosts = async () => {
    try {
      const data = await postsAPI.getAll(true);
      setPosts(data);
    } catch (error) {
      console.error('Error loading posts:', error);
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

  return (
    <div className="max-w-7xl mx-auto">
      <div className="text-center mb-12">
        <h1 className="text-5xl font-bold text-gray-800 mb-4">
          Welcome to Our Blog
        </h1>
        <p className="text-xl text-gray-600">
          Discover amazing stories and insights
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        {posts.map((post) => (
          <div
            key={post.id}
            className="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition transform hover:-translate-y-2"
          >
            <div className="p-6">
              <div className="flex items-center justify-between mb-4">
                <span className="bg-blue-100 text-blue-800 text-xs font-semibold px-3 py-1 rounded-full">
                  {post.category?.name}
                </span>
              </div>
              
              <h2 className="text-2xl font-bold text-gray-800 mb-3 line-clamp-2">
                {post.title}
              </h2>
              
              <p className="text-gray-600 mb-4 line-clamp-3">
                {post.content}
              </p>

              <div className="flex flex-wrap gap-2 mb-4">
                {post.tags?.map((tag) => (
                  <span
                    key={tag.id}
                    className="bg-gray-100 text-gray-700 text-xs px-2 py-1 rounded"
                  >
                    #{tag.name}
                  </span>
                ))}
              </div>

              <div className="flex items-center justify-between pt-4 border-t">
                <div className="text-sm text-gray-500">
                  By {post.user?.name}
                </div>
                <Link
                  to={`/post/${post.id}`}
                  className="text-blue-600 hover:text-blue-700 font-semibold"
                >
                  Read More →
                </Link>
              </div>
            </div>
          </div>
        ))}
      </div>

      {posts.length === 0 && (
        <div className="text-center text-gray-500 py-12">
          <p className="text-xl">No posts available yet.</p>
        </div>
      )}
    </div>
  );
};

export default Home;

