
const routes = [
  {
    path: '/',
    component: () => import('layouts/SignIn.vue'),
    children: [
      { path: '', component: () => import('pages/Index.vue') }
    ]
  },
  {
    path: '/signUp',
    component: () => import('layouts/SignUp.vue'),
    children: [
      { path: '', component: () => import('pages/Index.vue') }
    ]
  },
  {
    path: '/home',
    component: () => import('layouts/Home.vue'),
    children: [
      { path: '', component: () => import('pages/Index.vue') }
    ]
  },
  {
    path: '*',
    component: () => import('pages/404.vue')
  }
]
export default routes
