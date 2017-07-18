//
// LocationAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire



open class LocationAPI: APIBase {
    /**
     Create a new location for a device
     
     - parameter userId: (path) The id (UUID) of the user 
     - parameter deviceId: (path) The id (UUID) of the device 
     - parameter latitude: (form) The latitude of the device.  
     - parameter longitude: (form) The longitude of the device.  
     - parameter altitude: (form) The altitude of the device.  
     - parameter horizontalAccuracy: (form)  The horizontal accuracy of the location, measured on a scale from &#39;0.0&#39; to &#39;1.0&#39;, &#39;1.0&#39; being the most accurate. If this value is not specified then the default value of &#39;1.0&#39; is used  (optional, default to 5)
     - parameter verticalAccuracy: (form)  The vertical accuracy of the location, measured on a scale from &#39;0.0&#39; to &#39;1.0&#39;, &#39;1.0&#39; being the most accurate. If this value is not specified then the default value of &#39;1.0&#39; is used  (optional, default to 5)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createLocation(userId: String, deviceId: String, latitude: Double, longitude: Double, altitude: Double, horizontalAccuracy: Double? = nil, verticalAccuracy: Double? = nil, completion: @escaping ((_ data: DeviceLocation?,_ error: Error?) -> Void)) {
        createLocationWithRequestBuilder(userId: userId, deviceId: deviceId, latitude: latitude, longitude: longitude, altitude: altitude, horizontalAccuracy: horizontalAccuracy, verticalAccuracy: verticalAccuracy).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Create a new location for a device
     - POST /users/{userId}/devices/{deviceId}/locations
     - API Key:
       - type: apiKey api-key 
       - name: api-key
     - examples: [{contentType=application/json, example={
  "location" : {
    "altitude" : 1.3579000000000001069366817318950779736042022705078125,
    "verticalAccuracy" : 1.3579000000000001069366817318950779736042022705078125,
    "latitude" : 1.3579000000000001069366817318950779736042022705078125,
    "horizontalAccuracy" : 1.3579000000000001069366817318950779736042022705078125,
    "timestamp" : 123456789,
    "longitude" : 1.3579000000000001069366817318950779736042022705078125
  },
  "deviceId" : "aeiou"
}}]
     
     - parameter userId: (path) The id (UUID) of the user 
     - parameter deviceId: (path) The id (UUID) of the device 
     - parameter latitude: (form) The latitude of the device.  
     - parameter longitude: (form) The longitude of the device.  
     - parameter altitude: (form) The altitude of the device.  
     - parameter horizontalAccuracy: (form)  The horizontal accuracy of the location, measured on a scale from &#39;0.0&#39; to &#39;1.0&#39;, &#39;1.0&#39; being the most accurate. If this value is not specified then the default value of &#39;1.0&#39; is used  (optional, default to 5)
     - parameter verticalAccuracy: (form)  The vertical accuracy of the location, measured on a scale from &#39;0.0&#39; to &#39;1.0&#39;, &#39;1.0&#39; being the most accurate. If this value is not specified then the default value of &#39;1.0&#39; is used  (optional, default to 5)

     - returns: RequestBuilder<DeviceLocation> 
     */
    open class func createLocationWithRequestBuilder(userId: String, deviceId: String, latitude: Double, longitude: Double, altitude: Double, horizontalAccuracy: Double? = nil, verticalAccuracy: Double? = nil) -> RequestBuilder<DeviceLocation> {
        var path = "/users/{userId}/devices/{deviceId}/locations"
        path = path.replacingOccurrences(of: "{userId}", with: "\(userId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{deviceId}", with: "\(deviceId)", options: .literal, range: nil)
        let URLString = AlpsAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "latitude": latitude,
            "longitude": longitude,
            "altitude": altitude,
            "horizontalAccuracy": horizontalAccuracy,
            "verticalAccuracy": verticalAccuracy
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<DeviceLocation>.Type = AlpsAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

}