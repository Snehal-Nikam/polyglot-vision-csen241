<template>
  <q-layout view="lHh Lpr lFf">
    <div class="container">
      <q-card>
        <img class="avatar" src="tubarao.jpg" />
        <q-card-section>
          <q-form @submit="Register" class="q-gutter-md q-pa-sm">
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
              label="Confirm Password"
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