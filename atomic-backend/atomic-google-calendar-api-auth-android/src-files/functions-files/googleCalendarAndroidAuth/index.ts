import { handlerPath } from '@libs/handler-resolver';

export default {
  handler: `${handlerPath(__dirname)}/handler.main`,
  events: [
    {
      http: {
        method: 'post',
        path: 'google-calendar-android-auth',
        // request: {
        //   schemas: {
        //     'application/json': schema,
        //   },
        // },
        cors: true,
        authorizer: {
          arn: 'YOUR-AWS-COGNITO-ARN'
        }
      },
    },
  ],
};
