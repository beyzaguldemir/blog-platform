import axios from './axios';

export const postsAPI = {
  getAll: async (published = null) => {
    const params = published !== null ? { published } : {};
    const response = await axios.get('/posts', { params });
    return response.data;
  },

  getOne: async (id) => {
    const response = await axios.get(`/posts/${id}`);
    return response.data;
  },

  create: async (data) => {
    const response = await axios.post('/posts', data);
    return response.data;
  },

  update: async (id, data) => {
    const response = await axios.put(`/posts/${id}`, data);
    return response.data;
  },

  delete: async (id) => {
    const response = await axios.delete(`/posts/${id}`);
    return response.data;
  },
};

