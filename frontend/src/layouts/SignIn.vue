<template>
  <q-layout view="lHh Lpr lFf">
    <div class="container">
      <q-card>
        <img class="avatar" src="tubarao.jpg" />
        <q-card-section>
          <q-form class="q-gutter-md q-pa-sm" @submit="login">
            <q-input
              v-model="user.username"
              label="Your email"
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

            <div>
              <q-btn
                :loading="loading"
                label="To enter"
                type="submit"
                color="primary"
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