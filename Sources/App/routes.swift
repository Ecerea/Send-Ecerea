import Vapor
import Alamofire

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.post("sms")  { req -> HTTPResponse in
        guard let bodyData = req.http.body.data else {
            return HTTPResponse(status: .badRequest)
        }
        let destinationNumber = String(decoding: bodyData, as: UTF8.self)
        let accountSID = "ACbb00427a272fdcb6ec99bffb98e5835b"
        let authToken = "663a31a2de2244bfcd5b83225740bb02"
        let twilioNumber = "+17206193365"
        let url = "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages"
        let parameters = ["From": twilioNumber, "To": destinationNumber, "Body": "https://itunes.apple.com/us/app/ecerea/id1444619493"]
            
        Alamofire.request(url, method: .post, parameters: parameters)
            .authenticate(user: accountSID, password: authToken)
            .responseJSON { response in
                print(response)
        }
        return HTTPResponse(status: .ok)
        
        
        // Declare a multi-line string literal of some TwiML to respond with.
//        let twiml = """
//        <?xml version="1.0" encoding="UTF-8"?>
//        <Response>
//            <Message><![CDATA[https://itunes.apple.com/us/app/enbloc/id1271878178]]></Message>
//        </Response>
//        """
//
//        // Create an HTTP Response with the twiml as the body.
//        var response = HTTPResponse(status: .ok, body: twiml)
//        response.contentType = .xml
//        return response
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
