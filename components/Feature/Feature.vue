<template>
  <div class="root" v-if="loaded">
    <v-container fixed>
      <v-row class="spacing8">
        <v-col md="4" cols="12" class="py-1 px-8"  v-for="content in testiContent" :key="content.id">
          <i class="icon" :class="content.icon" />
          <v-divider class="divider" />
          <h5 class="use-text-subtitle">
            {{ content.title }}
          </h5>
          <p class="use-text-paragraph">
            {{ content.desc }}
          </p>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<style lang="scss" scoped>
@import './feature-style.scss';
</style>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      loaded: false,
      testiContent: [],
    }
  },
  mounted() {
    axios.get(`${process.env.backendUrl}/api/landing/feature/`)
    .then((response) => {
      this.testiContent = response.data
    })
    .catch((e) => {
      console.log(e)
    })
    .finally(() => {
      this.loaded = true
    })
  }
}
</script>
