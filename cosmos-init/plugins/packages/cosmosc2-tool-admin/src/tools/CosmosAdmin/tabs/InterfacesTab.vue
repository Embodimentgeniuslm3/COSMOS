<!--
# Copyright 2021 Ball Aerospace & Technologies Corp.
# All Rights Reserved.
#
# This program is free software; you can modify and/or redistribute it
# under the terms of the GNU Affero General Public License
# as published by the Free Software Foundation; version 3 with
# attribution addendums as found in the LICENSE.txt
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# This program may also be used under the terms of a commercial or
# enterprise edition license of COSMOS if purchased from the
# copyright holder
-->

<template>
  <div>
    <v-alert
      :type="alertType"
      v-model="showAlert"
      dismissible
      transition="scale-transition"
    >
      {{ alert }}
    </v-alert>
    <v-list data-test="interfaceList">
      <div v-for="cosmos_interface in interfaces" :key="cosmos_interface">
        <v-list-item>
          <v-list-item-content>
            <v-list-item-title v-text="cosmos_interface" />
          </v-list-item-content>
          <v-list-item-icon>
            <v-tooltip bottom>
              <template v-slot:activator="{ on, attrs }">
                <v-icon
                  @click="showInterface(cosmos_interface)"
                  v-bind="attrs"
                  v-on="on"
                >
                  mdi-eye
                </v-icon>
              </template>
              <span>Show Interface Details</span>
            </v-tooltip>
          </v-list-item-icon>
          <v-list-item-icon>
            <v-tooltip bottom>
              <template v-slot:activator="{ on, attrs }">
                <v-icon
                  @click="deleteInterface(cosmos_interface)"
                  v-bind="attrs"
                  v-on="on"
                >
                  mdi-delete
                </v-icon>
              </template>
              <span>Delete Interface</span>
            </v-tooltip>
          </v-list-item-icon>
        </v-list-item>
        <v-divider />
      </div>
    </v-list>
    <v-alert
      :type="alertType"
      v-model="showAlert"
      dismissible
      transition="scale-transition"
    >
      {{ alert }}
    </v-alert>
    <edit-dialog
      :content="jsonContent"
      :title="`Interface: ${dialogTitle}`"
      :readonly="true"
      v-model="showDialog"
      v-if="showDialog"
      @submit="dialogCallback"
    />
  </div>
</template>

<script>
import Api from '@cosmosc2/tool-common/src/services/api'
import EditDialog from '@/tools/CosmosAdmin/EditDialog'
export default {
  components: { EditDialog },
  data() {
    return {
      interfaces: [],
      alert: '',
      alertType: 'success',
      showAlert: false,
      jsonContent: '',
      dialogTitle: '',
      showDialog: false,
    }
  },
  mounted() {
    this.update()
  },
  methods: {
    update() {
      Api.get('/cosmos-api/interfaces')
        .then((response) => {
          this.interfaces = response.data
        })
        .catch((error) => {
          this.alert = error
          this.alertType = 'error'
          this.showAlert = true
          setTimeout(() => {
            this.showAlert = false
          }, 5000)
        })
    },
    showInterface(name) {
      Api.get(`/cosmos-api/interfaces/${name}`)
        .then((response) => {
          this.jsonContent = JSON.stringify(response.data, null, '\t')
          this.dialogTitle = name
          this.showDialog = true
        })
        .catch((error) => {
          this.alert = error
          this.alertType = 'error'
          this.showAlert = true
          setTimeout(() => {
            this.showAlert = false
          }, 5000)
        })
    },
    dialogCallback(content) {
      this.showDialog = false
    },
    deleteInterface(name) {
      var that = this
      this.$dialog
        .confirm(`Are you sure you want to remove: ${name}`, {
          okText: 'Delete',
          cancelText: 'Cancel',
        })
        .then(function (dialog) {
          Api.delete(`/cosmos-api/interfaces/${name}`)
            .then((response) => {
              that.alert = `Removed interface ${name}`
              that.alertType = 'success'
              that.showAlert = true
              setTimeout(() => {
                that.showAlert = false
              }, 5000)
              that.update()
            })
            .catch((error) => {
              that.alert = error
              that.alertType = 'error'
              that.showAlert = true
              setTimeout(() => {
                that.showAlert = false
              }, 5000)
            })
        })
    },
  },
}
</script>
