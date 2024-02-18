<script>
import authService from '../service/authService'
export default {
  data () {
    return {
      user: {
        password: '',
        username: ''
      },
      loading: false
    }
  },
  methods: {
    async login () {
      const { username, password } = this.user
      try {
        this.loading = true
        await authService.signIn({ username, password })
        this.$router.push('home')
      } catch (err) {
        this.$q.notify({
          message: 'Incorrect email or password',
          color: 'red'
        })
      } finally {
        this.loading = false
      }
    }
  }
}
</script>