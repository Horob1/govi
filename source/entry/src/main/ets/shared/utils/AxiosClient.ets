import axios, { AxiosResponse } from "@ohos/axios";
import { Logger } from "./Logger";

// Cross-platform HTTP via @ohos/axios ^2.2.15 (OpenHarmony TPC, Axios adapt).
// Per DEPENDENCIES.md 3.7 - ApiClient responsibility. This is cross (ArkTS + ArkUI-X), no BridgePlugin needed.
// Native fallback remains ApiClient (http) for HarmonyOS http kit. Choose one per feature.

export interface AxiosApiResponse<T> {
  data: T;
  status: number;
}

export class AxiosClient {
  private baseUrl: string = "";

  constructor(baseUrl: string = "") {
    this.baseUrl = baseUrl;
  }

  async get<T>(path: string): Promise<AxiosApiResponse<T>> {
    const url: string = this.baseUrl + path;
    Logger.info("AxiosClient GET %{public}s", url);
    const res: AxiosResponse = await axios.get(url);
    return { data: res.data as T, status: res.status ?? 200 };
  }

  async post<T>(path: string, body: Object): Promise<AxiosApiResponse<T>> {
    const url: string = this.baseUrl + path;
    Logger.info("AxiosClient POST %{public}s", url);
    const res: AxiosResponse = await axios.post(url, body);
    return { data: res.data as T, status: res.status ?? 200 };
  }
}

export const axiosClient: AxiosClient = new AxiosClient();
