import api from './api'

const list = async (userid) => {
  const { data: response } = await api.get(`/list?id=${userid}`, {
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, DELETE, PUT',
      'Access-Control-Allow-Headers': 'X-Requested-With, Content-Type, Authorization, Origin, Accept'
    }
  })
  return response
}

const send = async (data) => {
  const { data: response } = await api.post('/send', data, {
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Access-Control-Allow-Origin': '*'
    }
  })
  return response
}

export default {
  list,
  send
}
