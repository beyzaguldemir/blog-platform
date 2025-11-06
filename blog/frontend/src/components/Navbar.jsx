import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const Navbar = () => {
  const { user, logout, isAdmin } = useAuth();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  return (
    <nav className="bg-gradient-to-r from-blue-600 to-purple-600 text-white shadow-lg">
      <div className="container mx-auto px-4">
        <div className="flex justify-between items-center h-16">
          <Link to="/" className="text-2xl font-bold hover:text-blue-200 transition">
            Blog Platform
          </Link>

          <div className="flex items-center space-x-6">
            <Link to="/" className="hover:text-blue-200 transition">
              Home
            </Link>
            
            {user ? (
              <>
                {isAdmin() && (
                  <>
                    <Link to="/admin/posts" className="hover:text-blue-200 transition">
                      Posts
                    </Link>
                    <Link to="/admin/categories" className="hover:text-blue-200 transition">
                      Categories
                    </Link>
                    <Link to="/admin/tags" className="hover:text-blue-200 transition">
                      Tags
                    </Link>
                    <Link to="/admin/users" className="hover:text-blue-200 transition">
                      Users
                    </Link>
                  </>
                )}
                {!isAdmin() && (
                  <Link to="/my-posts" className="hover:text-blue-200 transition">
                    My Posts
                  </Link>
                )}
                <div className="flex items-center space-x-4">
                  <span className="text-sm">
                    Welcome, <span className="font-semibold">{user.name}</span>
                  </span>
                  <button
                    onClick={handleLogout}
                    className="bg-red-500 hover:bg-red-600 px-4 py-2 rounded-lg transition"
                  >
                    Logout
                  </button>
                </div>
              </>
            ) : (
              <>
                <Link
                  to="/login"
                  className="hover:text-blue-200 transition"
                >
                  Login
                </Link>
                <Link
                  to="/register"
                  className="bg-white text-blue-600 hover:bg-blue-50 px-4 py-2 rounded-lg transition font-semibold"
                >
                  Register
                </Link>
              </>
            )}
          </div>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;

