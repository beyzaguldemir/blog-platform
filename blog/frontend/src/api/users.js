import axios from './axios';

export const usersAPI = {
  getAll: async () => {
    const response = await axios.get('/users');
    return response.data;
  },

  getOne: async (id) => {
    const response = await axios.get(`/users/${id}`);
    return response.data;
  },

  update: async (id, data) => {
    const response = await axios.put(`/users/${id}`, data);
    return response.data;
  },

  delete: async (id) => {
    const response = await axios.delete(`/users/${id}`);
    return response.data;
  },
};

