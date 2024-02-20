
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
