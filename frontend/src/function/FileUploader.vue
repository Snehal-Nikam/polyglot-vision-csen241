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
      />
    </div>

    <q-table
      :loading="loading"
      class="q-mx-lg"
      hide-pagination
      title="My uploads"
      :data="uploadsData"
      :columns="columns"
      row-key="name"
      loading-label="Loading..."
      no-results-label="No results found"
      no-data-label="You haven't uploaded any files yet"
    >
       <template v-slot:body-cell-download="props">
        <q-td :props="props">
          <q-btn :disable="!props.value" type="a" :href="props.value" round color="secondary" icon="cloud_download" />
        </q-td>
      </template>
    </q-table>
  </q-page>
</template>