import { createConsumer } from '@rails/actioncable';

$(document).on('turbolinks:load', () => {
  const urlsTableEl = $('#urls-datatable');

  if (urlsTableEl.length === 0)
    return;

  const animationDuration = 5000;

  // initializes the table
  const urlsTableDt =
    $('#urls-datatable').DataTable({
      autoWidth: false,
      processing: true,
      responsive: true,
      serverSide: false,
      lengthChange: false,
      paging: false,
      bInfo: false,
      language: {
        emptyTable: 'You have not generated any short urls.',
        zeroRecords: 'No matching urls found.'
      },
      rowId: (data) => `urls-row-${data.id}`,
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

  // adds row to table if Url record created successfully
  $('.shortener_form').on('ajax:success', (event) => {
    const [data, _status, _xhr] = event.detail;

    urlsTableDt.row.add(data).draw();
    urlsTableDt.order([[0, 'desc']]).draw();

    urlsTableEl
      .find('tbody tr:first-child')
      .effect('highlight', {}, animationDuration);

    alert('Success!');
  });

  // displays error if Url record creation failed
  $('.shortener_form').on('ajax:error', (event) => {
    const [data, _status, _xhr] = event.detail;

    alert(`Error! ${data}`);
  })

  // updates visits count for individul records in real-time using ActionCable
  createConsumer().subscriptions.create('UrlChannel', { received: (data) => {
    const rowId = `#urls-row-${data.id}`;
    const visitsTd = $(`${rowId} td:nth-child(3)`);

    const rowDt = urlsTableDt.row(`#urls-row-${data.id}`);
    rowDt.data(data).draw();

    visitsTd.effect('highlight', {}, animationDuration);
  }})
});
