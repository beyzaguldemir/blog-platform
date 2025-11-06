import axios from './axios';

export const authAPI = {
  login: async (email, password) => {
    const response = await axios.post('/auth/login', { email, password });
    return response.data;
  },

  register: async (name, email, password, password_confirmation) => {
    const response = await axios.post('/auth/register', {
      name,
      email,
      password,
      password_confirmation,
    });
    return response.data;
  },

  getCurrentUser: async () => {
    const response = await axios.get('/users/me');
    return response.data;
  },
};

