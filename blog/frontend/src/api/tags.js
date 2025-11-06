import axios from './axios';

export const tagsAPI = {
  getAll: async () => {
    const response = await axios.get('/tags');
    return response.data;
  },

  getOne: async (id) => {
    const response = await axios.get(`/tags/${id}`);
    return response.data;
  },

  create: async (data) => {
    const response = await axios.post('/tags', data);
    return response.data;
  },

  update: async (id, data) => {
    const response = await axios.put(`/tags/${id}`, data);
    return response.data;
  },

  delete: async (id) => {
    const response = await axios.delete(`/tags/${id}`);
    return response.data;
  },
};

