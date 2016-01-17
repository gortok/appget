using System;
using System.Net;

namespace AppGet.Http
{
    public class HttpRequestBuilder
    {
        public Uri BaseUri { get; }
        public bool SuppressHttpError { get; set; }
        public NetworkCredential NetworkCredential { get; set; }

        public Action<HttpRequest> PostProcess { get; set; }

        public HttpRequestBuilder(string baseUri)
        {
            BaseUri = new Uri(baseUri);
        }

        public virtual HttpRequest Build(string path)
        {
            if (BaseUri.ToString().EndsWith("/"))
            {
                path = path.TrimStart('/');
            }

            var request = new HttpRequest(BaseUri + path)
            {
                SuppressHttpError = SuppressHttpError,
                NetworkCredential = NetworkCredential
            };

            PostProcess?.Invoke(request);

            return request;
        }
    }
}