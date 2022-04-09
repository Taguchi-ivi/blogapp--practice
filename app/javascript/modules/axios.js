import axios from 'axios' 

// postメソッドの対応 yarn add rails-ujs
import { csrfToken } from 'rails-ujs'

// 鍵を持っている人のみpostできるようにする的な
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

export default axios