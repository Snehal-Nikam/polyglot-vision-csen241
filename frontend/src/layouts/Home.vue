<template>
    <q-layout view="lHh Lpr lFf">
      <q-header elevated>
        <q-toolbar class="bg-black text-white">
          <q-btn
            flat
            dense
            round
            icon="menu"
            @click="leftDrawerOpen = !leftDrawerOpen"
          />
          <img src="~assets/Polyglot.jpg" width="5%" height="50px">
          <q-toolbar-title>Welcome {{user.name}}</q-toolbar-title>
          <q-btn flat dense round icon="logout" @click="signOut"/>
        </q-toolbar>
      </q-header>

      <q-drawer
        v-model="leftDrawerOpen"
        bordered
        :width="250"
        content-class="bg-grey-1"
      >
        <q-list>
          <template v-for="(menuItem, index) in menuLinks">
            <q-item
              :key="index"
              clickable
              :active="index == activeIndex"
              @click="setActive(index)"
            >
              <q-item-section avatar>
                <q-icon :name="menuItem.icon" />
              </q-item-section>
              <q-item-section>{{ menuItem.label }}</q-item-section>
            </q-item>
            <q-separator :key="'sep' + index" v-if="menuItem.separator" />
          </template>
        </q-list>
      </q-drawer>
      <q-page-container>
        <FileUploader v-if="activeIndex == 0" />
      </q-page-container>
    </q-layout>
  </template>

<script>
const menuList = [
  {
    icon: 'home',
    label: 'Start'
  }
]
import FileUploader from '../function/FileUploader'
import authService from '../service/authService'
export default {
  components: { FileUploader },
  data () {
    return {
      leftDrawerOpen: false,
      menuLinks: menuList,
      activeIndex: 0,
      user: {}
    }
  },
  methods: {
    setActive (idx) {
      this.activeIndex = idx
    },
    async signOut () {
      try {
        await authService.signOut()
        this.$router.push('/')
      } catch (err) {
        console.log(err)
        this.$q.notify({
          message: 'Error when exiting the application',
          color: 'red'
        })
      }
    }
  },
  async created () {
    const { attributes: data } = await authService.getCurrentUser()
    this.user = data
  }
}
</script>
