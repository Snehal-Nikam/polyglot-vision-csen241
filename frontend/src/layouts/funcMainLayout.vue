<script>
const menuList = [
  {
    icon: 'home',
    label: 'Start'
  },
  {
    icon: 'account_box',
    label: 'Profile',
    separator: true
  },
  {
    icon: 'info',
    label: 'About'
  }
]

import FileUploader from '../function/FileUploader'
export default {
  components: { FileUploader },
  data () {
    return {
      leftDrawerOpen: false,
      menuLinks: menuList,
      activeIndex: 0
    }
  },
  methods: {
    setActive (idx) {
      this.activeIndex = idx
    }
  }
}
</script>
