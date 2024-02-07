<template>
  <q-layout view="lHh Lpr lFf">
    <div class="container">
      <q-card>
        <img class="avatar" src="tubarao.jpg" />
        <q-card-section>
          <q-form @submit="register" class="q-gutter-md q-pa-sm">
            <q-input
              v-model="user.name"
              label="Your name"
              lazy-rules
              :rules="[(val) => (val && val.length > 0) || 'Blank field']"
            />

            <q-input
              v-model="user.email"
              label="Email"
              lazy-rules
              :rules="[(val) => (val && val.length > 0) || 'Blank field']"
            />

            <q-input
              type="password"
              v-model="user.password"
              label="Password"
              lazy-rules
              :rules="[(val) => (val && val.length > 0) || 'Blank field']"
            />

            <q-input
              type="password"
              v-model="confpass"
              label="confirm password"
              lazy-rules
              :rules="[
                (val) => (val && val.length > 0) || 'Blank field',
                (val) => val === user.password || 'Passwords do not match',
              ]"
            />

            <div>
              <q-btn
                :loading="loading"
                label="Register"
                type="submit"
                color="primary"
              />
            </div>
          </q-form>
        </q-card-section>
      </q-card>
    </div>
  </q-layout>
</template>

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
          message: 'Error processing data',
          color: 'red'
        })
      } finally {
        this.loading = false
      }
    }
  }
}
</script>

<style lang="stylus" scoped>
.container {
  display: flex;
  justify-content: center;
}

.q-card {
  margin-top: 60px;
  height: 580px;
  width: 400px;
  display: flex;
  flex-direction: column;
}

.q-icon {
  margin: 5px;
  margin-left: auto;
  padding: 10px;
  border-radius: 5px;
  font-size: 15px;
  cursor: pointer;
  transition: all 0.2;
}

.q-icon:hover {
  background-color: #aaa;
}

.avatar {
  margin: 10px auto;
  width: 100px;
  height: 100px;
  border-radius: 50%;
}

.q-btn {
  width: 100%;
  height: 40px;
}
</style>
