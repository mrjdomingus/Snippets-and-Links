# How-To Add Fetch API to node

Install [cross-fetch](https://www.npmjs.com/package/cross-fetch) npm package via `npm install --save cross-fetch`

Import **fetch** function and add as option to **useClient** call in **setup** method.
```
<script lang="ts">
import { defineComponent } from '@vue/composition-api'
import fetch from 'cross-fetch'
import { useClient } from 'villus'

export default defineComponent({
  setup () {
    useClient({
      'url': 'https://pet-library.moonhighway.com/',
      fetch,
    })
  },
})
</script>
```
