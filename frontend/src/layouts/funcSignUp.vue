<script>
import authService from '../service/authService'
export default {
  data () {
    return {
      user: {
        name: '',
        password: '',
        email: ''
      },
      confpass: '',
      loading: false
    }
  },
  methods: {
    async Register () {
      const { email: username, password, name } = this.user
      try {
        this.loading = true
        await authService.signUp({ username, password, name })
        this.$router.push('/')
      } catch (err) {
        this.$q.notify({
          message: 'Erro ao processar dados',
          color: 'red'
        })
      } finally {
        this.loading = false
      }
    }
  }
}
</script>