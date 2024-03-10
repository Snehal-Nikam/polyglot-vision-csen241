<template>
    <q-layout view="lHh Lpr lFf">
      <div class="container">
        <q-card>
          <img class="avatar" src="~assets/Polyglot.jpg" />
          <q-card-section>
            <q-form class="q-gutter-md q-pa-sm" @submit="login">
              <q-input rounded outlined
                v-model="user.username"
                label="Your email"
                lazy-rules
                :rules="[(val) => (val && val.length > 0) || 'Blank field']"
              />

              <q-input rounded outlined
                type="password"
                v-model="user.password"
                label="Password"
                lazy-rules
                :rules="[(val) => (val && val.length > 0) || 'Blank field']"
              />

              <div>
                <q-btn
                  :loading="loading"
                  label="To enter"
                  type="submit"
                  outline style="color: secondary;"
                  rounded
                  icon-right="send"
                />
              </div>

              <div class="row justify-center">
                <span
                  >Not registered?<span
                    class="signUp"
                    @click="$router.push('signUp')"
                  >
                    Register</span
                  >
                </span>
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
  <style lang="stylus" scoped>
  .container {
    display: flex;
    justify-content: center;
  }
  .q-card {
    margin-top: 100px;
    width: 350px;
    height: 420px;
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
    width: 70%;
    height: 40%;
    border-radius: 50%;
  }
  .signUp {
    cursor: pointer;
    color: $primary;
    /*color: #3371e3 !important;*/
    align-self: flex-end;
  }
  .q-btn {
    height: 40px;
    width: 100%;
  }
  </style>
