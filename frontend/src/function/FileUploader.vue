<template>
  <q-page>
    <div class="uploader-container">
      <q-uploader
        ref="uploader"
        @finish="finished"
        label="Add a file .mp4"
        auto-upload
        extensions=".mp4"
        :factory="uploadVideo"
        :filter="checkFileType"
        @rejected="onRejected"
        color="indigo-9"
        text-color="white"
      />
    </div>
    <div class="q-pa-md">
      <q-table
        :loading="loading"
        class="q-mx-xl "
        hide-pagination
        title="My uploads"
        :data="uploadsData"
        :columns="columns"
        row-key="name"
        card-class="bg-white text-black"
        table-class="text-black"
        loading-label="Loading..."
        no-results-label="No results found"
        no-data-label="You haven't uploaded any files yet"
      >

        <!--      table-class="bg-blue text-white"-->

        <template v-slot:body-cell-download="props">
          <q-td :props="props">
            <q-btn :disable="!props.value" type="a" :href="props.value" round color="secondary" icon="cloud_download" />
          </q-td>
        </template>
      </q-table>
    </div>
  </q-page>
</template>

<script>
import videoService from '../service/videoService'
import authService from '../service/authService'
const ALLOWED_FILE_TIPES = ['video/mp4']
export default {
  data () {
    return {
      uploadsData: [],
      loading: false,
      columns: [
        {
          label: 'Nome',
          field: 'video_name',
          required: true,
          align: 'left',
          sortable: true
        },
        {
          name: 'duration',
          label: 'Duration',
          field: 'duration',
          sortable: true,
          format: (val) => this.formatTime(val)
        },
        { label: 'Transcribed words', field: 'transcription_words', sortable: true },
        { label: 'Translated words', field: 'translation_words', sortable: true },
        {
          label: 'Status',
          field: 'finished',
          sortable: true,
          format: (val) => val === 'True' ? 'Finished' : 'In progress'
        },
        { label: 'Download', field: 'video_uri', name: 'download' }
      ]
    }
  },
  methods: {
    checkFileType (files) {
      return files.filter((file) => ALLOWED_FILE_TIPES.includes(file.type))
    },
    onRejected (rejectedEntries) {
      this.$q.notify({
        type: 'negative',
        message: 'Invalid file type'
      })
    },
    formatTime (duration) {
      if (duration) { return duration >= 60 ? `${duration / 60} min` : `${duration} s` }
      return ''
    },
    async uploadVideo (files) {
      try {
        const file = files[0]
        const { attributes } = await authService.getCurrentUser()
        const formData = new FormData()
        formData.set('file_name', file.name)
        formData.set('user_id', attributes.sub)
        formData.set('user_email', attributes.email)
        formData.append('file', file)
        await videoService.send(formData)
        this.$q.notify({
          type: 'positive',
          message: 'Video sent successfully'
        })
      } catch {
        this.$q.notify({
          type: 'negative',
          message: 'Error sending file'
        })
      } finally {
        this.listUploads()
      }
    },
    async listUploads () {
      try {
        this.loading = true
        const { username } = await authService.getCurrentUser()
        this.uploadsData = await videoService.list(username)
      } catch (err) {
        this.$q.notify({
          type: 'negative',
          message: 'Error loading upload list'
        })
      } finally {
        this.loading = false
      }
    },
    finished () {
      this.$refs.uploader.reset()
    }
  },
  created () {
    this.listUploads()
  }
}
</script>
<style lang="stylus" scoped>
.uploader-container {
  padding: 80px 0;
  display: flex;
  align-items: center;
  justify-content: center;
}

</style>
