$(document).on('turbolinks:load', () => {
  const urlsTableEl = $('#urls-datatable');
  const urlsTableDt =
    $('#urls-datatable').DataTable({
      autoWidth: false,
      processing: true,
      responsive: true,
      serverSide: false,
      lengthChange: false,
      pageLength: 5,
      ajax: {
        'url': $('#urls-datatable').data('source')
      },
      pagingType: 'simple',
      columns: [
        { data: 'id' },
        { data: 'url',
          render: (data) =>  `<a href='${data}' target='_blank'>${data}</a>`
        },
        { data: 'short_url',
          render: (data) =>  `<a href='${data}' target='_blank'>${data}</a>`
        },
        { data: 'visits' }
      ],
      columnDefs: [
        {
          targets: [0],
          visible: false,
          searchable: false
        }
      ],
      order: [[0, 'desc']]
    });

  $('.shortener_form').on('ajax:success', (event) => {
    const [data, _status, _xhr] = event.detail;

    urlsTableDt.row.add(data).draw();
    urlsTableDt.order([[0, 'desc']]).draw();

    urlsTableEl.find('tbody tr:first-child').effect('highlight', {}, 5000);

    alert('Success!');
  });

  $('.shortener_form').on('ajax:error', (event) => {
    const [data, _status, _xhr] = event.detail;

    alert(`Error! ${data}`);
  })
});
