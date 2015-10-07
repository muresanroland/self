ready = ->
  fromDate = $('#fromDate').find 'input'
  toDate = $('#toDate').find 'input'
  tableSelector = $('#eventsTable')
  $('select').select2()

  table = tableSelector.dataTable
    processing: true
    serverSide: true
    ajax: tableSelector.data 'source'
    autoWidth: false
    order: [[ 0, 'desc' ]]
    fnServerParams: (aoData) ->
      aoData.from = fromDate.val()
      aoData.to = toDate.val()

      return

  $('#exportXls').on 'click', (e)->
    $this = $(this)

    filter = $('#eventsTable_filter').find('input').val()
    params = ['from=' + fromDate.val(), 'to=' + toDate.val(), 'search_query=' + filter].join '&'
    url = $this.data('source') + '?' + params

    $this.attr 'href', url
    true

  fromDate.add(toDate).on "change", ->
    table.fnDraw()
    return

  # fromDate.customDatepicker {}
  # toDate.customDatepicker {}

$(document).ready ready
$(document).on 'page:load', ready