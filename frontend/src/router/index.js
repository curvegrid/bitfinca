import Vue from 'vue';
import Router from 'vue-router';

import Home from '@/components/Home.vue';
import BorrowApplication from '@/components/Borrow/BorrowApplication.vue';
import Borrow from '@/components/Borrow/Borrow.vue';
import BusinessDashboard from '@/components/Borrow/BusinessDashboard.vue';
import Lend from '../components/Lend/Lend.vue';
import Browse from '../components/Lend/Browse.vue';
import Support from '../components/Validation/Support.vue';
import ValidatePage from '../components/Validation/ValidatePage.vue'
import About from '../components/About.vue';
import ManageTokens from '../components/ManageTokens.vue';
import Details from '../components/Lend/Details.vue';
import NotFound from '@/components/NotFound.vue';

Vue.use(Router);

const routes = [
  {
    path:'/',
    name:'Home',
    component: Home,
  },
  {
    path: '/borrow',
    name: 'Borrow',
    component: Borrow,
  },
  {
    path: '/borrowapplication',
    name: 'Borrow Application',
    component: BorrowApplication,
  },
  {
    path: '/dashboard',
    name: 'Business Dashboard',
    component: BusinessDashboard,
  },
  {
    path: '/dashboard/:id',
    name: 'Business Dashboard ID',
    component: BusinessDashboard,
    props: (route) => ({
      create: false,
      id: route.params.id,
    }),
  },
  {
    path:'/lend',
    name:'Lend',
    component: Lend,
  },
  {
    path:'/browse',
    name:'Browse',
    component: Browse,
  },
  {
    path:'/details',
    name:'Details',
    component: Details,
  },
  {
    path:'/details/:id',
    name:'Details ID',
    component: Details,
    props: (route) => ({
      create: false,
      id: route.params.id,
    })
  },
  {
    path:'/support',
    name:'Support',
    component: Support,
  },
  {
    path:'/validate',
    name:'Validate',
    component: ValidatePage,
  },
  {
    path: '/about',
    name: 'About Us',
    component: About,
  },
  {
    path:'/manageTokens',
    name:'Manage Tokens',
    component: ManageTokens,
  },
  {
    path: "/*",
    component: NotFound,
  },
];

const router = new Router({
  mode: 'hash',
  routes,
  base: process.env.BASE_URL,
});

export default router;
