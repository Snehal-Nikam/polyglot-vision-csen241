<script>
const menuList = [
  {
    icon: 'home',
    label: 'Início'
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