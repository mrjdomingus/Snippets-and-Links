<template>
  <v-layout>
    <v-flex class="text-center">
      <img src="/v.png" alt="Vuetify.js" class="mb-5">
      <blockquote class="blockquote">
        &#8220;{{ message }}&#8221;
        <footer>
          <small>
            <em>&mdash;John Johnson</em>
          </small>
        </footer>
      </blockquote>
    </v-flex>
  </v-layout>
</template>

<script lang='ts'>
import { createComponent, ref } from '@vue/composition-api'

export default createComponent({
  setup () {
    const message = ref('First, solve the problem. Then, write the code using the Composition API.')

    return {
      message
    }
  }
})
</script>
