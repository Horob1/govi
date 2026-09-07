import http from "@ohos.net.http";
import { Logger } from "./Logger";

export interface ApiResponse<T> {
  data: T;
  status: number;
  headers: Record<string, string>;
}

export interface ApiError {
  code: number;
  message: string;
}

export class ApiClient {
  private baseUrl: string = "";
  private timeout: number = 10000;
  private defaultHeaders: Record<string, string> = {
    "Content-Type": "application/json"
  };

  constructor(baseUrl: string = "", timeout: number = 10000) {
    this.baseUrl = baseUrl;
    this.timeout = timeout;
  }

  setAuthToken(token: string): void {
    this.defaultHeaders["Authorization"] = "Bearer " + token;
  }

  clearAuth(): void {
    delete this.defaultHeaders["Authorization"];
  }

  async get<T>(path: string, headers?: Record<string, string>): Promise<ApiResponse<T>> {
    return this.request<T>("GET", path, undefined, headers);
  }

  async post<T>(path: string, body?: Object, headers?: Record<string, string>): Promise<ApiResponse<T>> {
    return this.request<T>("POST", path, body, headers);
  }

  async put<T>(path: string, body?: Object, headers?: Record<string, string>): Promise<ApiResponse<T>> {
    return this.request<T>("PUT", path, body, headers);
  }

  async del<T>(path: string, headers?: Record<string, string>): Promise<ApiResponse<T>> {
    return this.request<T>("DELETE", path, undefined, headers);
  }

  private async request<T>(
    method: string,
    path: string,
    body?: Object,
    extraHeaders?: Record<string, string>
  ): Promise<ApiResponse<T>> {
    const url: string = this.baseUrl + path;
    const headers: Record<string, string> = {};
    // merge default headers
    for (const k in this.defaultHeaders) {
      headers[k] = this.defaultHeaders[k];
    }
    if (extraHeaders) {
      for (const k in extraHeaders) {
        headers[k] = extraHeaders[k];
      }
    }

    Logger.info("ApiClient %{public}s %{public}s", method, url);

    return new Promise((resolve, reject): void => {
      const req: http.HttpRequest = http.createHttp();
      const methodEnum: http.RequestMethod =
        method === "POST" ? http.RequestMethod.POST :
        method === "PUT" ? http.RequestMethod.PUT :
        method === "DELETE" ? http.RequestMethod.DELETE :
        http.RequestMethod.GET;

      const options: http.HttpRequestOptions = {
        method: methodEnum,
        header: headers,
        connectTimeout: this.timeout,
        readTimeout: this.timeout,
        extraData: body ? JSON.stringify(body) : undefined
      };

      req.request(url, options, (err: BusinessError, data: http.HttpResponse): void => {
        req.destroy();
        if (err) {
          Logger.error("ApiClient error %{public}s", JSON.stringify(err));
          const apiErr: ApiError = { code: err.code, message: err.message };
          reject(apiErr as Object as Error);
          return;
        }
        const res: ApiResponse<T> = {
          data: data.result as T,
          status: data.responseCode,
          headers: data.header as Record<string, string>
        };
        if (res.status >= 200 && res.status < 300) {
          resolve(res);
        } else {
          const apiErr: ApiError = { code: res.status, message: JSON.stringify(res.data) };
          reject(apiErr as Object as Error);
        }
      });
    });
  }
}

// Minimal BusinessError shape for ArkTS strict without any
interface BusinessError {
  code: number;
  message: string;
}

export const apiClient: ApiClient = new ApiClient();
