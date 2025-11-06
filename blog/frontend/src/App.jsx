import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext';
import Layout from './components/Layout';
import ProtectedRoute from './components/ProtectedRoute';

// Pages
import Home from './pages/Home';
import Login from './pages/Login';
import Register from './pages/Register';
import Categories from './pages/Categories';
import Tags from './pages/Tags';
import Users from './pages/Users';
import Posts from './pages/Posts';
import PostDetail from './pages/PostDetail';

function App() {
  return (
    <AuthProvider>
      <Router>
        <Routes>
          {/* Public routes */}
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          
          {/* Protected routes */}
          <Route
            path="/"
            element={
              <Layout>
                <Home />
              </Layout>
            }
          />

          <Route
            path="/post/:id"
            element={
              <Layout>
                <PostDetail />
              </Layout>
            }
          />

          {/* Admin only routes */}
          <Route
            path="/admin/categories"
            element={
              <ProtectedRoute adminOnly>
                <Layout>
                  <Categories />
                </Layout>
              </ProtectedRoute>
            }
          />

          <Route
            path="/admin/tags"
            element={
              <ProtectedRoute adminOnly>
                <Layout>
                  <Tags />
                </Layout>
              </ProtectedRoute>
            }
          />

          <Route
            path="/admin/users"
            element={
              <ProtectedRoute adminOnly>
                <Layout>
                  <Users />
                </Layout>
              </ProtectedRoute>
            }
          />

          <Route
            path="/admin/posts"
            element={
              <ProtectedRoute adminOnly>
                <Layout>
                  <Posts />
                </Layout>
              </ProtectedRoute>
            }
          />

          {/* User routes */}
          <Route
            path="/my-posts"
            element={
              <ProtectedRoute>
                <Layout>
                  <Posts />
                </Layout>
              </ProtectedRoute>
            }
          />
        </Routes>
      </Router>
    </AuthProvider>
  );
}

export default App;
